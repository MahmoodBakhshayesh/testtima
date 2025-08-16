import 'dart:async';
import 'package:flutter/material.dart';

class ResendTimerController extends ChangeNotifier {
  final int maxSeconds;
  Timer? _timer;
  int _remaining;

  ResendTimerController({this.maxSeconds = 60}) : _remaining = 0;

  int get remaining => _remaining;
  bool get isRunning => _timer?.isActive ?? false;

  /// Start or restart the countdown
  void start() {
    _remaining = maxSeconds;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _remaining--;
      notifyListeners();
      if (_remaining <= 0) {
        _timer?.cancel();
      }
    });
    notifyListeners();
  }

  /// Cancel and reset to 0
  void cancel() {
    _timer?.cancel();
    _remaining = 0;
    notifyListeners();
  }

  /// Only reset the remaining time to 0 (optional separate method)
  void reset() => cancel();

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
