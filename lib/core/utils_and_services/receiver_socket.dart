// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:abds/core/classes/receiver_data_class.dart';
// import 'package:artemis_cupps/utility/cupps_util.dart';
// import 'package:artemis_utils/artemis_utils.dart';
// import 'package:dio/dio.dart';
// import 'package:get/get.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:signalr_netcore/ihub_protocol.dart';
// import 'package:signalr_netcore/iretry_policy.dart';
// import 'package:signalr_netcore/json_hub_protocol.dart';
// import 'package:signalr_netcore/signalr_client.dart';
// import 'package:logging/logging.dart';
// import '../../initialize.dart';
// import '../../screens/receiver/receiver_state.dart';
// import '../classes/basic_class.dart';
// import 'handlers/notify_handlers.dart';
// import 'package:cc_signalr/src/cc_signalr.dart';
// import 'package:cc_signalr/src/cc_signalr_options.dart';
// import 'package:cc_signalr/src/modules/hub_module.dart';
//
// // final receiverStatusProvider = StateProvider<HubConnectionState>((ref) => HubConnectionState.Disconnected);
//
//
// class ReceiverSocket {
//   ReceiverSocket._();
//
//   static String? _groupId;
//   static String? _connectionID;
//   static ReceiverData? _connectionUrl;
//   static WidgetRef ref = getIt<WidgetRef>();
//
//   String? get connectionID => _connectionID;
//
//   static final ReceiverSocket _instance = ReceiverSocket._();
//
//   factory ReceiverSocket() => _instance ?? ReceiverSocket._();
//   static String? flightCurrentSubscription;
//   static String? dateCurrentSubscription;
//
//   static List<String> groups = [];
//
//   static void setGroupsMemory(List<String> mem) {
//     groups = mem;
//   }
//
//   static Future<void> connect(ReceiverData data) async {
//     try {
//       // String url = "wss://multidcs.com";
//
//       log("Connecting to ${data.url}");
//       _connectionUrl = data;
//       var headers = MessageHeaders()..setHeaderValue("token", data.token)..setHeaderValue("yourId", data.yourId);
//       log("$headers");
//       CCSignalR.init(
//         connectionOptions: HttpConnectionOptions(
//           skipNegotiation: true,
//           transport: HttpTransportType.WebSockets,
//           logMessageContent: false,
//           headers: headers
//
//         ),
//         signalROptions: CCSignalROptions(
//           url: data.url,
//           autoReconnect: true,
//           hubProtocol: JsonHubProtocol(),
//           onConnected: (HubConnection connection) async {
//             print("ReceiverSocket Connected");
//             rejoinGroups();
//           },
//           onDisconnected: (value) {
//             print("ReceiverSocket Disconnected");
//           },
//           onReconnected: (value) {
//             print("ReceiverSocket Reconnected");
//             rejoinGroups();
//           },
//         ),
//         loggingOptions: CCSignalRLogging(
//           logEnabled: false,
//           logLevel: Level.INFO,
//         ),
//         modules: [
//           Notif()
//         ],
//       );
//       CCSignalR.hubConnection.keepAliveIntervalInMilliseconds = 4000;
//       CCSignalR.hubConnection.stateStream.forEach((a) {
//         log('Hub Status Updated ${a.name}');
//         ref.read(receiverStatusProvider.notifier).update((s) => a);
//       });
//       CCSignalR.connect();
//       // CCSignalR.register(Notif());
//       CCSignalR.hubConnection.on("Notify", (arguments) {
//         NotifyHandlers.handleSocketEvent(arguments);
//       });
//       // CCSignalR.getModule<Notif>().subscribe();
//
//     } catch (e) {
//       log('$e');
//       if (e is Error) {
//         print(e.stackTrace);
//       }
//     }
//   }
//
//   static Future<void> subscribeGroup(String group) async {
//
//   }
//
//
//
//
//
//
//   static Future<void> disconnect() async {
//     await CCSignalR.hubConnection.stop();
//     ref.read(receiverStatusProvider.notifier).update((s) => CCSignalR.hubConnection.state ?? HubConnectionState.Disconnected);
//   }
//
//   static Future<void> hold() async {
//     await disconnect();
//   }
//
//   static Future<void> unHold() async {
//     await connect(_connectionUrl!);
//     rejoinGroups();
//   }
//
//   static Future<void> rejoinGroups() async {
//     for (var g in groups.toSet().toList()) {
//       subscribeGroup(g);
//     }
//   }
//
//
// }
//
// class Notif extends HUBModule {
//   Notif() : super("Notify");
//
//   @override
//   void listen(List<Object?>? parameters) {
//     NotifyHandlers.handleSocketEvent(parameters);
//     // print("Broadcast : " + parameters.toString());
//   }
// }
//
// class CustomRetryPolicy implements IRetryPolicy {
//   final int maxAttempts;
//   final Duration retryInterval;
//
//   CustomRetryPolicy({this.maxAttempts = 100, this.retryInterval = const Duration(milliseconds: 3000)});
//
//   @override
//   int? nextRetryDelayInMilliseconds(RetryContext retryContext) {
//     getIt<WidgetRef>().read(receiverStatusProvider.notifier).update((s) => HubConnectionState.Connecting);
//     log("retry connecting to socket ${retryContext.retryReason}  ${retryContext.previousRetryCount}");
//     final retryCount = retryContext.previousRetryCount;
//     if (retryCount >= maxAttempts) {
//       return null;
//     }
//     return retryInterval.inMilliseconds;
//   }
// }
