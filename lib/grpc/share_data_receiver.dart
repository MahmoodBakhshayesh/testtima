import 'dart:async';
import 'dart:math' hide log;
import 'dart:developer';
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';

// ✅ adjust these to your generated files
import 'generated/shareData.pbgrpc.dart';
import 'grpc_channel.dart';
import 'grpc_channel_factory.dart';

enum GrpcStreamStatus { idle, connecting, connected, disconnected, error }

class ShareDataReceiver {
  ShareDataReceiver({
    required this.url, // e.g. "sharedata.multidcs.com/grpc" or "https://sharedata.multidcs.com/grpc"
    required this.token,
    required this.yourId,
    required this.onMessage,
    this.heartbeatInterval = const Duration(seconds: 10),
    this.callTimeout = const Duration(minutes: 30),
    this.maxBackoff = const Duration(minutes: 30),
  });

  final String url;
  final String token;
  final String yourId;
  final void Function(ShareDataResponse msg) onMessage;

  final Duration heartbeatInterval;
  final Duration callTimeout;
  final Duration maxBackoff;

  final _statusCtrl = StreamController<GrpcStreamStatus>.broadcast();

  Stream<GrpcStreamStatus> get statusStream => _statusCtrl.stream;

  ClientChannelBase? _channel;
  StreamController<ShareDataRequest>? _outgoing;
  StreamSubscription<ShareDataResponse>? _sub;
  StreamSubscription<ConnectionState>? _channelStateSub;

  Timer? _heartbeat;
  Timer? _reconnectTimer;

  bool _stopped = true;
  bool _connecting = false;

  int _attempt = 0;
  final _rng = Random();

  // Call this once (or when you want to begin)
  Future<void> start() async {
    _stopped = false;
    _attempt = 0;
    await _connect();
  }

  // Stops and prevents auto-reconnect
  Future<void> stop() async {
    _stopped = true;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    await _teardown();
    _statusCtrl.add(GrpcStreamStatus.idle);
  }

  // Force an immediate reconnect attempt
  Future<void> reconnectNow() async {
    if (_stopped) return;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    await _connect(force: true);
  }

  void dispose() {
    _stopped = true;
    _reconnectTimer?.cancel();
    _heartbeat?.cancel();
    _statusCtrl.close();
    // Best-effort teardown (no await in dispose)
    _sub?.cancel();
    _channelStateSub?.cancel();
    _outgoing?.close();
    _channel?.shutdown();
  }

  /// Gracefully disconnects WITHOUT scheduling reconnect
  Future<void> disconnect() async {
    // prevent any future reconnects
    _stopped = true;

    // cancel pending reconnect attempt
    _reconnectTimer?.cancel();
    _reconnectTimer = null;

    // stop heartbeat
    _heartbeat?.cancel();
    _heartbeat = null;

    // close outgoing stream (client -> server)
    await _outgoing?.close();
    _outgoing = null;

    // cancel incoming stream subscription
    await _sub?.cancel();
    _sub = null;

    // stop listening to channel state
    await _channelStateSub?.cancel();
    _channelStateSub = null;

    // shutdown channel
    final ch = _channel;
    _channel = null;
    if (ch != null) {
      await ch.shutdown();
    }

    _statusCtrl.add(GrpcStreamStatus.disconnected);
  }

  // ---------------- Internals ----------------

  Uri _normalizeUri(String input) {
    final fixed = input.startsWith('http://') || input.startsWith('https://') ? input : 'https://$input';
    return Uri.parse(fixed);
  }

  Duration _nextBackoff() {
    // exponential: 1s,2s,4s,8s,... capped
    final seconds = min(1 << min(_attempt, 5), maxBackoff.inSeconds); // cap growth
    // jitter: add 0..500ms
    final jitterMs = _rng.nextInt(500);
    return Duration(seconds: seconds) + Duration(milliseconds: jitterMs);
  }

  void _scheduleReconnect(Object reason) {
    if (_stopped) return;

    _statusCtrl.add(GrpcStreamStatus.disconnected);

    final delay = _nextBackoff();
    _attempt++;

    log('Scheduling reconnect in ${delay.inMilliseconds}ms: $reason');

    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(delay, () {
      if (_stopped) return;
      _connect();
    });
  }

  Future<void> _connect({bool force = false}) async {
    if (_stopped) return;
    if (_connecting && !force) return;

    _connecting = true;

    // tear down any previous connection first
    await _teardown();

    _statusCtrl.add(GrpcStreamStatus.connecting);

    final uri = _normalizeUri(url);
    final host = uri.host;
    final port = uri.hasPort ? uri.port : 443;

    _channel = GrpcChannelFactory(GrpcConfig(host: host, port: 443)).create();
    // _channel = ClientChannel(
    //   host,
    //   port: port,
    //   options: const ChannelOptions(
    //     credentials: ChannelCredentials.secure(),
    //   ),
    // );

    // Listen to channel state changes (reactive only)
    _channelStateSub = _channel!.onConnectionStateChanged.listen((state) {
      log('Channel state: $state');
      if (state == ConnectionState.ready) {
        _statusCtrl.add(GrpcStreamStatus.connected);
      }
      if (state == ConnectionState.transientFailure || state == ConnectionState.shutdown) {
        _scheduleReconnect(state);
      }
    });

    final client = ShareDataServiceClient(_channel!);

    _outgoing = StreamController<ShareDataRequest>();

    // Start heartbeat (keeps nginx/proxy from killing idle streams)
    _heartbeat?.cancel();
    _heartbeat = Timer.periodic(heartbeatInterval, (_) {
      _outgoing?.add(ShareDataRequest());
    });

    try {
      // Start the bidi stream
      final stream = client.shareData(
        _outgoing!.stream,
        options: CallOptions(
          timeout: callTimeout,
          metadata: {
            // ✅ adjust header names to what backend expects:
            // often "authorization": "Bearer $token"
            'token': token,
            'yourId': yourId,
          },
        ),
      );

      // Send initial subscribe/hello
      _outgoing!.add(ShareDataRequest());

      _sub = stream.listen(
        (msg) {
          // first data received => connected
          _attempt = 0; // reset backoff on success
          _statusCtrl.add(GrpcStreamStatus.connected);
          onMessage(msg);
        },
        onError: (e, st) {
          log('Stream error: $e', stackTrace: st);
          _statusCtrl.add(GrpcStreamStatus.error);
          _scheduleReconnect(e);
        },
        onDone: () {
          log('Stream done');
          _scheduleReconnect('onDone');
        },
        cancelOnError: true,
      );
    } catch (e, st) {
      log('Connect exception: $e', stackTrace: st);
      _statusCtrl.add(GrpcStreamStatus.error);
      _scheduleReconnect(e);
    } finally {
      _connecting = false;
    }
  }

  Future<void> _teardown() async {
    _heartbeat?.cancel();
    _heartbeat = null;

    await _sub?.cancel();
    _sub = null;

    await _channelStateSub?.cancel();
    _channelStateSub = null;

    await _outgoing?.close();
    _outgoing = null;

    final ch = _channel;
    _channel = null;
    if (ch != null) {
      await ch.shutdown();
    }
  }
}
