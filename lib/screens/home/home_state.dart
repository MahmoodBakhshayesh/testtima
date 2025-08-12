import 'package:abds/core/utils_and_services/import_toggler.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/utils_and_services/timatic/artemis_timatic.dart';

final homeProvider = ChangeNotifierProvider<HomeState>((_) => HomeState());

class HomeState extends ChangeNotifier {
  void setState() => notifyListeners();

  ///bool loading = false;

}


final timaticResultProvider = StateProvider<DocumentResponse?>((ref) => null);
// final documentProvider = StateProvider<List<DocumentDetail>>((ref) => [DocumentDetail(documentCode: null)]);
final passportsProvider = StateProvider<List<DocumentDetail>>((ref) => [DocumentDetail(documentCode: null)]);
final visasProvider = StateProvider<List<DocumentDetail>>((ref) => [DocumentDetail(documentCode: null)]);
final passengerProvider = StateProvider<PassengerDetails>((ref) => PassengerDetails());
final segmentsProvider = StateProvider<List<ItinerarySegment>>((ref) => [ItinerarySegment.empty()]);
final documentNumberProvider =  StateProvider<String>((ref) => "");