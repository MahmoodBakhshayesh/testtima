import 'dart:async';
import 'package:flutter/widgets.dart';

String formatMinSecMillisMicros(Duration d) {
  final minutes = d.inMinutes.toString().padLeft(2, '0');
  final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
  final millis = (d.inMilliseconds % 1000).toString().padLeft(3, '0');
  final micros = (d.inMicroseconds % 1000).toString().padLeft(3, '0');

  return "$minutes:$seconds:$millis:$micros";
}


/// Controls the elapsed timer: start, pause, reset, etc.
class TimerController extends ChangeNotifier {
  Duration _elapsed = Duration.zero;
  Timer? _timer;

  Duration get elapsed => _elapsed;
  bool get isRunning => _timer != null;

  /// Start counting. Does nothing if already running.
  void start() {
    if (_timer != null) return;

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _elapsed += const Duration(seconds: 1);
      notifyListeners();
    });
  }

  /// Pause without resetting the elapsed time.
  void pause() {
    _timer?.cancel();
    _timer = null;
    notifyListeners();
  }

  /// Reset elapsed time to zero.
  ///
  /// If [stop] is true, it also pauses the timer.
  void reset({bool stop = false}) {
    if (stop) {
      pause();
    }
    _elapsed = Duration.zero;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

/// Signature for building the timer UI.
typedef ElapsedTimerBuilder = Widget Function(
    BuildContext context,
    Duration elapsed,
    );

/// Widget that listens to [TimerController] and rebuilds using [builder]
/// whenever elapsed time changes.
class ElapsedTimer extends StatefulWidget {
  final TimerController controller;
  final ElapsedTimerBuilder builder;

  const ElapsedTimer({
    Key? key,
    required this.controller,
    required this.builder,
  }) : super(key: key);

  @override
  State<ElapsedTimer> createState() => _ElapsedTimerState();
}

class _ElapsedTimerState extends State<ElapsedTimer> {
  late TimerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _controller.addListener(_onTick);
  }

  @override
  void didUpdateWidget(covariant ElapsedTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onTick);
      _controller = widget.controller;
      _controller.addListener(_onTick);
    }
  }

  void _onTick() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTick);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _controller.elapsed);
  }
}

/// Simple helper to format a [Duration] as `HH:MM:SS`.
String formatDuration(Duration d) {
  final hours = d.inHours.toString().padLeft(2, '0');
  final minutes = (d.inMinutes % 60).toString().padLeft(2, '0');
  final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
  return '$hours:$minutes:$seconds';
}
