import 'package:abds/core/classes/timatic_response_new_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/classes/current_status_class.dart';
import '../../core/classes/ref_history_log_class.dart';
import '../../core/utils_and_services/timatic/src/models/document_request.dart';

final resultReportStateProvider = ChangeNotifierProvider<ResultReportState>((_) => ResultReportState());

class ResultReportState extends ChangeNotifier {
  void setState() => notifyListeners();

  ///bool loading = false;

}

final reportPassportsProvider = StateProvider<List<DocumentDetail>>((ref) => []);
final reportVisasProvider = StateProvider<List<DocumentDetail>>((ref) => []);
final reportResidentsProvider = StateProvider<List<DocumentDetail>>((ref) => []);
final reportPassengerProvider = StateProvider<PassengerDetails>((ref) => PassengerDetails());
final reportShowingLogsProvider =  StateProvider<List<RefHistoryLog>>((ref) => []);
final reportSegmentsProvider =  StateProvider<List<ItinerarySegment>>((ref) => []);
final reportCurrentStatusProvider =  StateProvider<CurrentStatus>((ref) => CurrentStatus());
final reportRefCodeShowProvider =  StateProvider<String?>((ref) =>null);
final reportRefCodeProvider =  StateProvider<String?>((ref) =>null);
final reportTimaticResultNewProvider =  StateProvider<TimaticResponseNew?>((ref) =>null);

