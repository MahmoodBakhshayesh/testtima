import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:abds/core/classes/receiver_data_class.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as ws_status;
import '../../initialize.dart';
import '../../screens/login/login_state.dart';
import '../classes/basic_class.dart';
import 'handlers/notify_handlers.dart';

final webSocketStatusProvider = StateProvider<WebSocketConnectionState>((ref) => WebSocketConnectionState.disconnected);

enum WebSocketConnectionState { connecting, connected, disconnected }

class ReceiverSocket {
  ReceiverSocket._();

  static final ReceiverSocket _instance = ReceiverSocket._();
  factory ReceiverSocket() => _instance;

  static WidgetRef ref = getIt<WidgetRef>();
  static WebSocketChannel? _channel;
  static StreamSubscription? _subscription;


  static String? flightCurrentSubscription;
  static String? dateCurrentSubscription;
  static final List<String> groups = [];

  static bool _manuallyDisconnected = false;
  static Timer? _retryTimer;
  static ReceiverData? data;
  // static String get _url => '${BasicClass.settings.userSettings.acpsURL}?'
  //     'username=${BasicClass.settings.userSettings.userInfo}'
  //     '&DeviceID=${BasicClass.deviceInfo?.deviceKey}'
  //     '&BuildKey=${BasicClass.buildKey}'
  //     '&usertype=${BasicClass.settings.userSettings.userType}'
  //     '&token=${BasicClass.settings.userSettings.token}'
  //     '&serverid=${BasicClass.settings.userSettings.serverID}'
  //     '&systemtype=${BasicClass.settings.userSettings.systemType}';
  static String get _url => 'wss://multidcs.com';

  static Future<void> connect(ReceiverData d) async {
    _manuallyDisconnected = false;
    data= d;
    _connectInternal(data!.url);
  }

  static void _connectInternal([String? address]) {
    try {
      String url = address??_url;
      ref.read(webSocketStatusProvider.notifier).state = WebSocketConnectionState.connecting;


      final uri = Uri.parse(url).replace(queryParameters: {
        'token': data!.token,
        'yourId': data!.yourId,
      });
      log("Connecting to WebSocket ${uri}");
      _channel = WebSocketChannel.connect(Uri.parse(url).replace(queryParameters: {
        'token': data!.token,
        'yourId': data!.yourId,
      }));
      _channel!.sink.add(jsonEncode({
        "token": data!.token,
        "yourID": data!.yourId,
      }));
      _subscription = _channel!.stream.listen(
        _onMessage,
        onDone: () {
          log("WebSocket Disconnected");
          ref.read(webSocketStatusProvider.notifier).state = WebSocketConnectionState.disconnected;
          if (!_manuallyDisconnected) _scheduleReconnect();
        },
        onError: (err) {
          log("WebSocket Error: $err");
          ref.read(webSocketStatusProvider.notifier).state = WebSocketConnectionState.disconnected;
          if (!_manuallyDisconnected) _scheduleReconnect();
        },
      );

      ref.read(webSocketStatusProvider.notifier).state = WebSocketConnectionState.connected;
      _rejoinGroups();
    } catch (e, st) {
      log('WebSocket connection failed: $e');
      log('$st');
      _scheduleReconnect();
    }
  }

  static void _scheduleReconnect() {
    _retryTimer?.cancel();
    // _retryTimer = Timer(const Duration(seconds: 3), _connectInternal);
  }

  static Future<void> disconnect() async {
    _manuallyDisconnected = true;
    _retryTimer?.cancel();
    await _subscription?.cancel();
    await _channel?.sink.close(ws_status.goingAway);
    ref.read(webSocketStatusProvider.notifier).state = WebSocketConnectionState.disconnected;
  }

  static Future<void> hold() => disconnect();

  static Future<void> unHold() => connect(data!);

  static void _onMessage(dynamic message) {
    log("ws msg: ${message.runtimeType}");
    if(message.runtimeType == String){
      log(message);
      try {
        final decoded = jsonDecode(message);
        NotifyHandlers.handleWebSocketEvent(decoded);
      } catch (e) {
        log('Invalid message: $e');
      }
      // return;
    }else if(message.runtimeType is Map<String,dynamic>){
      NotifyHandlers.handleWebSocketEvent(message);
    }

  }

  static void _send(String event, Map<String, dynamic> payload) {
    final message = jsonEncode({
      'event': event,
      'data': payload,
    });
    _channel?.sink.add(message);
  }

  static Future<void> subscribeGroup(String group) async {
    if (!groups.contains(group)) {
      final token = ref.read(userProvider)?.token ?? '';
      groups.add(group);
      _send('SubscribeToGroup', {
        'token': token,
        'group': group,
      });
      log("Subscribed to $group");
    }
  }

  static Future<void> unsubscribeGroup(String group) async {
    if (groups.contains(group)) {
      final token = ref.read(userProvider)?.token ?? '';
      groups.remove(group);
      _send('UnSubscribeFromGroup', {
        'token': token,
        'group': group,
      });
      log("Unsubscribed from $group");
    }
  }


  static void subscribeDate(DateTime from, [DateTime? to]) {
    final dateRange = '${from.format_yyyyMMdd.replaceAll("-", "")}-${(to ?? from).format_yyyyMMdd.replaceAll("-", "")}';

    if (dateCurrentSubscription == dateRange) {
      log("Already subscribed to $dateRange");
      return;
    }

    if (dateCurrentSubscription != null) {
      unsubscribeDate();
    }

    _send('SubscribeToFlightChangeGroup', {
      'dateRange': dateRange,
      'token': ref.read(userProvider)?.token ?? '',
    });

    dateCurrentSubscription = dateRange;
    log("Subscribed Flight List $dateRange");
  }

  static void unsubscribeDate() {
    if (dateCurrentSubscription == null) return;

    _send('UnSubscribeFromGroup', {
      'token': ref.read(userProvider)?.token ?? '',
      'group': dateCurrentSubscription,
    });

    log("Unsubscribed $dateCurrentSubscription");
    dateCurrentSubscription = null;
  }

  static void _rejoinGroups() {
    for (final group in groups.toSet()) {
      subscribeGroup(group);
    }
  }
}
