import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:developer' as dev;
import 'package:abds/core/utils_and_services/artemis_icons_icons.dart';
import 'package:abds/widgets/DotButton.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:voice_note_kit/voice_note_kit.dart';

import 'my_player.dart';

class MyVoiceRecorder extends StatefulWidget {
  /// Called after user presses **Submit** in review mode.
  /// You’ll get the final file path (non-null).
  final void Function(String path)? onSubmitRecord;

  /// Still available if you want to react immediately when recording stops.
  final void Function(String? path)? onDoneRecording;

  const MyVoiceRecorder({
    super.key,
    this.onSubmitRecord,
    this.onDoneRecording,
  });

  @override
  State<MyVoiceRecorder> createState() => _MyVoiceRecorderState();
}

enum _Mode { idle, recording, review }

class _MyVoiceRecorderState extends State<MyVoiceRecorder> {
  final AudioRecorder _recorder = AudioRecorder();
  final Stopwatch _stopwatch = Stopwatch();
  final AudioPlayer _player = AudioPlayer(); // for review playback

  Timer? _ticker;
  StreamSubscription<Amplitude>? _ampSub;

  Duration _elapsed = Duration.zero;
  bool _isPaused = false;
  double _level = 0.0;

  _Mode _mode = _Mode.idle;
  String? _currentTargetPath;   // file path during recording
  String? _lastRecordingPath;   // final file path after stop
  bool _isPlaying = false;

  @override
  void dispose() {
    _ticker?.cancel();
    _ampSub?.cancel();
    _recorder.dispose();
    _player.dispose();
    super.dispose();
  }

  Future<String> _nextFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    final recDir = Directory('${dir.path}/recordings');
    if (!await recDir.exists()) await recDir.create(recursive: true);
    final ts = DateTime.now().toIso8601String().replaceAll(':', '-');
    return '${recDir.path}/rec_$ts.m4a';
  }

  Future<void> _start() async {
    if (await _recorder.hasPermission()) {
      final path = await _nextFilePath();
      _currentTargetPath = path;

      await _recorder.start(
        const RecordConfig(
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          sampleRate: 44100,
        ),
        path: path,
      );

      _mode = _Mode.recording;
      _isPaused = false;

      // duration ticker
      _stopwatch
        ..reset()
        ..start();
      _ticker ??= Timer.periodic(const Duration(milliseconds: 200), (_) {
        setState(() => _elapsed = _stopwatch.elapsed);
      });

      // equalizer amplitude
      _ampSub ??= _recorder
          .onAmplitudeChanged(const Duration(milliseconds: 120))
          .listen((amp) {
        setState(() => _level = _dbToLevel(amp.current));
      });

      setState(() {});
    }
  }

  Future<void> _stop() async {
    final resultPath = await _recorder.stop();
    _stopwatch.stop();
    _ticker?.cancel();
    _ticker = null;
    await _ampSub?.cancel();
    _ampSub = null;

    _level = 0.0;
    _isPaused = false;

    _lastRecordingPath = resultPath ?? _currentTargetPath;
    _currentTargetPath = null;

    // let the caller know recording finished (optional)
    widget.onDoneRecording?.call(_lastRecordingPath);

    // jump to review mode only if we actually have a file
    setState(() {
      _mode = (_lastRecordingPath != null) ? _Mode.review : _Mode.idle;
    });
  }

  // Review: play/pause the recorded file
  Future<void> _togglePlay() async {
    if (_lastRecordingPath == null) return;

    if (_isPlaying) {
      await _player.pause();
      setState(() => _isPlaying = false);
      return;
    }

    // Prepare a new source if not already set or after completion
    await _player.play(DeviceFileSource(_lastRecordingPath!));
    setState(() => _isPlaying = true);

    // When the audio finishes, reset play state
    _player.onPlayerComplete.first.then((_) {
      if (mounted) setState(() => _isPlaying = false);
    });
  }

  // Delete the recorded file and go back to idle
  Future<void> _deleteAndReset() async {
    setState(() {
      _lastRecordingPath = null;
      _stopwatch.reset();
      _elapsed = Duration.zero;
      _mode = _Mode.idle;
    });
    // Stop player if needed
    if (_isPlaying) {
      await _player.stop();
      _isPlaying = false;
    }

    final p = _lastRecordingPath;
    if (p != null) {
      final f = File(p);
      if (await f.exists()) {
        try { await f.delete(); } catch (_) {}
      }
    }

    setState(() {
      _lastRecordingPath = null;
      _elapsed = Duration.zero;
      _mode = _Mode.idle;
    });

  }

  // Submit callback from review mode
  Future<void> _submit() async {
    if (_lastRecordingPath == null) return;
    if (_isPlaying) {
      await _player.stop();
      _isPlaying = false;
    }
    widget.onSubmitRecord?.call(_lastRecordingPath!);
    setState(() {
      _lastRecordingPath = null;
      _stopwatch.reset();
      _elapsed = Duration.zero;
      _mode = _Mode.idle;
    });
  }

  double _dbToLevel(double db) {
    if (db >= 0.0 && db <= 1.0) return db.clamp(0.0, 1.0);
    const minDb = -45.0;
    if (db.isNaN || db.isInfinite) return 0.0;
    if (db < minDb) db = minDb;
    if (db > 0) db = 0;
    final norm = (db - minDb) / -minDb; // 0..1
    return norm.clamp(0.0, 1.0);
  }

  String _format(Duration d) {

    final h = d.inHours;
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return h > 0 ? '$h:$m:$s' : '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    // Main action button: mic (blue), stop (red), play/pause (green)
    Widget mainButton;

    if (_mode == _Mode.idle) {
      mainButton = _CircleButton(
        color: Colors.blueAccent,
        icon: Icons.mic,
        onTap: _start,
      );
    } else if (_mode == _Mode.recording) {
      mainButton = _CircleButton(
        color: Colors.redAccent,
        icon: Icons.stop,
        onTap: _stop,
      );
    } else {
      // review
      mainButton = _CircleButton(
        color: Colors.green,
        icon: _isPlaying ? Icons.pause : Icons.play_arrow,
        onTap: _togglePlay,
      );
    }

    // Equalizer visible only while recording; dimmed otherwise
    final eqOpacity = (_mode == _Mode.recording) ? 1.0 : 0.25;

    if(_mode == _Mode.review){
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // mainButton,

          // const SizedBox(width: 8),

          // Equalizer
          Expanded(
            child: MyAudioPlayerWidget(
              autoPlay: false,
              autoLoad: true,
              showSpeedControl: false,
              audioPath: _lastRecordingPath,
              audioType: AudioType.directFile,
              playerStyle: PlayerStyle.style5,
              size: 45,
              progressBarHeight: 5,
              backgroundColor: Colors.transparent,
              progressBarColor: Colors.blueAccent,
              progressBarBackgroundColor: Colors.blueAccent,
              iconColor: Colors.blueAccent,
              shapeType: PlayIconShapeType.circular,
              showProgressBar: true,
              showTimer: true,
              width: 300,
              audioSpeeds: const [0.5, 1.0, 1.5, 2.0, 3.0],
            ),
          ),


          // In review mode, show Delete + Submit
          if (_mode == _Mode.review) ...[
            const SizedBox(width: 8),
            DotButton(
              icon: ArtemisIcons.trash,
              color: Colors.red,
              onPressed: _deleteAndReset,
            ),
            const SizedBox(width: 8),
            DotButton(
              icon: ArtemisIcons.tick_circle,
              color: Colors.green,
              onPressed: _submit,
            ),
          ],
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        mainButton,

        const SizedBox(width: 8),

        // Equalizer
        Expanded(
          child: SizedBox(
            height: 48,
            child: AnimatedOpacity(
              opacity: eqOpacity,
              duration: const Duration(milliseconds: 200),
              child: _Equalizer(level: _level),
            ),
          ),
        ),

        const SizedBox(width: 8),

        // Duration
        Text(
          _format(_elapsed),
          style: GoogleFonts.dmMono(fontSize: 12, fontWeight: FontWeight.bold),
        ),

        // In review mode, show Delete + Submit
        if (_mode == _Mode.review) ...[
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'Delete',
            icon: const Icon(Icons.delete_outline),
            onPressed: _deleteAndReset,
          ),
          const SizedBox(width: 2),
          IconButton(
            tooltip: 'Submit',
            icon: const Icon(Icons.check_circle_outline),
            onPressed: _submit,
          ),
        ],
      ],
    );
  }
}

/// Small animated circular button used for Record/Stop/Play states.
class _CircleButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback? onTap;

  const _CircleButton({
    required this.color,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3)),
          ],
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
            child: Icon(icon, key: ValueKey(icon), color: Colors.white, size: 25),
          ),
        ),
      ),
    );
  }
}

/// Equalizer bars widget (unchanged from your baseline)
class _Equalizer extends StatelessWidget {
  final double level;
  const _Equalizer({required this.level});

  @override
  Widget build(BuildContext context) {
    const barCount = 20;
    const maxH = 42.0;
    const minH = 2.0;
    final rnd = Random();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(barCount, (i) {
        final bias = 1.0 - (i - (barCount - 1) / 2).abs() / ((barCount - 1) / 2 + 0.0001);
        final stagger = 0.6 + 0.4 * bias;
        final jitter = (rnd.nextDouble() * 0.15) - 0.075;
        final h = (minH + (maxH - minH) * (level * stagger + jitter).clamp(0.0, 1.0));

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeOut,
            width: 4,
            height: h,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        );
      }),
    );
  }
}
