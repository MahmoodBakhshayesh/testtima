import 'dart:developer';

import 'package:abds/core/interfaces/local_data_base_int.dart';
import 'package:abds/core/utils_and_services/stateControllers/visas_state_controller.dart';
import 'package:abds/screens/login/login_state.dart';
import 'package:abds/screens/users/users_controller.dart';
import 'package:flutter/material.dart';

import '../../core/classes/basic_class.dart';
import '../../core/interfaces/controller_int.dart';
import 'package:logging/logging.dart';

import '../../core/utils_and_services/stateControllers/passports_state_controller.dart';
import '../../core/utils_and_services/stateControllers/segments_state_controller.dart';
import '../../core/utils_and_services/timatic/artemis_timatic.dart';
import '../../initialize.dart';
import '../../widgets/MyFieldPicker.dart';
import 'home_state.dart';

class HomeController extends ControllerInterface {
  final _log = Logger('HomeController');
  late TimaticApi timaticApi = getIt<TimaticApi>();

  void clear() {
    ref.read(passengerProvider.notifier).update((s) => PassengerDetails());
    // ref.read(visasProvider.notifier).update((s) => [DocumentDetail()]);
    ref.read(passportsProvider.notifier).removeAll();
    ref.read(visasProvider.notifier).removeAll();
    ref.read(segmentsProvider.notifier).removeAll();

    // ref.read(passportsProvider.notifier).update((s) => [DocumentDetail()]);
    // ref.read(segmentsProvider.notifier).update((s) => [ItinerarySegment.empty()]);
  }

  Future<void> setAirportDialog(BuildContext context) async {
    final current = BasicClass.timData.locations.of(LocationType.airport).firstWhereOrNull((a)=>a.code3 == ref.read(userProvider)?.profile.defaultAirport);
    final newVal = await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          // This moves content above the keyboard
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: PickerSheetWidget(value: current, searchBuilder: null, items: BasicClass.timData.locations.of(LocationType.airport), label: "Airport", itemToWidget: null, hasSearch: true),
        );
        // return PickerSheetWidget(items: widget.items, label: widget.placeholder ?? widget.label ?? '', itemToWidget: widget.itemToWidget, hasSearch: widget.hasSearch);
      },
      elevation: 2,
    );

    if(newVal is Location){
      log("set new to $newVal");
      await getIt<UsersController>().updateUserStation(newVal.code3);
    }
  }



  // UseCase UseCase = UseCase(repository: Repository());
}
