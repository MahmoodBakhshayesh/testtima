import 'package:abds/core/classes/timatic_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final logsStateProvider = ChangeNotifierProvider<LogsState>((_) => LogsState());

class LogsState extends ChangeNotifier {
  void setState() => notifyListeners();

  ///bool loading = false;

}


final logsProvider = StateProvider<List<TimaticLog>>((ref) => []);
final logsLoadingProvider = StateProvider<bool>((ref) => false);
