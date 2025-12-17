import 'dart:developer';

import 'package:abds/core/classes/receiver_data_class.dart';
import 'package:abds/screens/home/home_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../initialize.dart';
import '../../../screens/performance/performance_controller.dart';
import '../../../screens/receiver/receiver_state.dart';
import '../../classes/current_status_class.dart';
import '../../classes/ref_history_log_class.dart';
import '../../classes/sender_data_class.dart';
import '../../extenstions/context_exp.dart';
import '../../navigation/routes.dart';

abstract class NotifyHandlers {
  static WidgetRef ref = getIt<WidgetRef>();

  static void changePassengers(List<Object?>? arguments) {}

  static void changeFlights(List<Object?>? arguments) {}

  static void handleSocketEvent(List<Object?>? arguments) {}

  static void handleWebSocketEvent(Map<String, dynamic> decoded, ReceiverData receiver) {
    if (decoded['message'] == 'Alive') {
      ref.read(receiverDataProvider.notifier).update((s) => receiver);
      log("in here");
    }
    if (decoded.containsKey("command")) {
      String command = decoded["command"];
      switch (command) {
        case "data":
          Map<String, dynamic> data = decoded["data"]["response"];
          RefHistory his = RefHistory.fromJson(data);
          CurrentStatus status = CurrentStatus.fromJson(data["result"]);
          String? refCode = data["refCode"]?.toString();
          String? showCode = data["showCode"]?.toString();
          getIt<PerformanceController>().fillReportWithRefHistory(his, refCode, showCode, status);
          log("his ${his.showCode}");
          if (!getIt<HomeController>().navigation.context.isDesktop) {
            getIt<HomeController>().goNamed(Routes.resultReport);
          }
        case "connect":
          Map<String, dynamic> data = decoded["data"];
          SenderData senderData = SenderData.fromJson(data);
          ref.read(senderDataProvider.notifier).update((s) => senderData);
        case "disconnect":
          ref.read(senderDataProvider.notifier).update((s) => null);

      }
    }

    if (decoded["command"] == "data") {
      Map<String, dynamic> data = decoded["data"]["response"];
      RefHistory his = RefHistory.fromJson(data);
      CurrentStatus status = CurrentStatus.fromJson(data["result"]);
      String? refCode = data["refCode"]?.toString();
      String? showCode = data["showCode"]?.toString();
      getIt<PerformanceController>().fillReportWithRefHistory(his, refCode, showCode, status);
      log("his ${his.showCode}");
      if (!getIt<HomeController>().navigation.context.isDesktop) {
        getIt<HomeController>().goNamed(Routes.resultReport);
      }
    }
    log("handle");
  }
}
