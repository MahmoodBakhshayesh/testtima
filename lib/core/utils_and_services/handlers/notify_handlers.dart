import 'dart:developer';

abstract class NotifyHandlers {

  static void changePassengers(List<Object?>? arguments) {
  }

  static void changeFlights(List<Object?>? arguments) {

  }

  static void handleSocketEvent(List<Object?>? arguments) {}

  static void handleWebSocketEvent(decoded) {
    log("handle");
  }

}