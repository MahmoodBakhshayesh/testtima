import 'package:abds/core/utils_and_services/timatic/src/models/document_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final performanceStateProvider = ChangeNotifierProvider<PerformanceState>((_) => PerformanceState());

class PerformanceState extends ChangeNotifier {
  void setState() => notifyListeners();

  ///bool loading = false;

}


final reportsViewModeProvider = StateProvider<int>((ref) => 0);



