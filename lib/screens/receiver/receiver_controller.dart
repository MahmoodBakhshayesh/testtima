import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:abds/core/classes/ref_history_log_class.dart';
import 'package:abds/core/classes/sender_data_class.dart';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/core/utils_and_services/receiver_socket.dart';
import 'package:abds/screens/performance/performance_controller.dart';
import 'package:abds/screens/receiver/receiver_state.dart';
import 'package:abds/screens/receiver/usecases/get_receiver_qr_usecase.dart';
import 'package:abds/screens/receiver/usecases/send_to_receiver_usecase.dart';
import 'package:grpc/grpc.dart';
import 'package:logging/logging.dart';
import '../../core/classes/current_status_class.dart';
import '../../core/classes/receiver_data_class.dart';
import '../../core/interfaces/controller_int.dart';
import '../../core/interfaces/result_int.dart';
import '../../core/navigation/routes.dart';
import '../../core/utils_and_services/handlers/failure_handler.dart';
import '../../core/utils_and_services/recevier_socket_new.dart';
import '../../grpc/clients/share_data_client.dart';
import '../../grpc/generated/shareData.pbgrpc.dart';
import '../../grpc/grpc_channel.dart';
import '../../grpc/share_data_receiver.dart';
import '../../initialize.dart';

class ReceiverController extends ControllerInterface {
  final _log = Logger('ReceiverController');

  Future<ReceiverData?> getReceiverData() async {
    ReceiverData? data;
    GetReceiverQrUseCase getReceiverDataUseCase = GetReceiverQrUseCase();
    GetReceiverQrRequest getReceiverQrRequest = GetReceiverQrRequest();
    final result = await getReceiverDataUseCase(request: getReceiverQrRequest);

    switch (result) {
      case Err<GetReceiverQrResponse>():
        FailureHandler.handle(result.error);

      case Ok<GetReceiverQrResponse>():
        final r = result.value;
        data = r.data;
        ref.read(receiverDataProvider.notifier).update((s) => r.data);
        initReceiver();
    }

    return data;
  }

  // initReceiver() {
  //   final receiveData = ref.read(receiverDataProvider);
  //   if (receiveData == null) {
  //     return;
  //   }
  //   // final channel = GrpcChannelFactory(GrpcConfig(host:"sharedata.multidcs.com", port: 443, useTls: true)).create();
  //
  //   final channel = ClientChannel(
  //     receiveData.url,
  //     port: 443, // HTTPS default
  //     options: const ChannelOptions(credentials: ChannelCredentials.secure()),
  //   );
  //
  //   // final channel = GrpcChannelFactory(GrpcConfig(host: "https://develope-timatic.multidcs.com/api/v1/"+receiveData.url, port: 443, useTls: true)).create();
  //
  //   final client = ShareDataServiceClient(channel);
  //   final api = ShareDataGrpcApi(client);
  //
  //   final controller = StreamController<ShareDataRequest>();
  //
  //   // Listen to responses (server -> client)
  //   final sub = api
  //       .shareData(requests: controller.stream, metadata: {'token': receiveData.token, 'yourId': receiveData.yourId})
  //       .listen((res) => log('Response: ${res}'), onError: (e) => log('gRPC error: $e'));
  //
  //   // Send requests (client -> server)
  //   controller.add(ShareDataRequest());
  //   // controller.add(ShareDataRequest());
  // }

  // initReceiver() {
  //   final receiveData = ref.read(receiverDataProvider);
  //   if (receiveData == null) return;
  //
  //   // final uri = Uri.parse(
  //   //   receiveData.url.startsWith('http')
  //   //       ? receiveData.url
  //   //       : 'https://${receiveData.url}',
  //   // );
  //
  //   final channel = ClientChannel(receiveData.url, port: 443, options: const ChannelOptions(credentials: ChannelCredentials.secure()));
  //
  //   // 1️⃣ Channel state (event-based)
  //   channel.onConnectionStateChanged.listen((state) {
  //     switch (state) {
  //       case ConnectionState.ready:
  //         ref.read(receiverStatusProvider.notifier).state = GrpcStreamStatus.connected;
  //         break;
  //       case ConnectionState.connecting:
  //         ref.read(receiverStatusProvider.notifier).state = GrpcStreamStatus.connecting;
  //         break;
  //       case ConnectionState.transientFailure:
  //       case ConnectionState.shutdown:
  //         ref.read(receiverStatusProvider.notifier).state = GrpcStreamStatus.disconnected;
  //         break;
  //       default:
  //         break;
  //     }
  //   });
  //
  //   final client = ShareDataServiceClient(channel);
  //   final controller = StreamController<ShareDataRequest>();
  //
  //   // 2️⃣ Stream lifecycle (PRIMARY signal)
  //   client
  //       .shareData(
  //         controller.stream,
  //         options: CallOptions(timeout: const Duration(minutes: 30), metadata: {'authorization': 'Bearer ${receiveData.token}', 'yourId': receiveData.yourId}),
  //       )
  //       .listen(
  //         (res) {
  //           // receiving data = connected
  //           ref.read(receiverStatusProvider.notifier).state = GrpcStreamStatus.connected;
  //           log('Response: $res');
  //         },
  //         onError: (e) {
  //           ref.read(receiverStatusProvider.notifier).state = GrpcStreamStatus.error;
  //           log('gRPC error: $e');
  //         },
  //         onDone: () {
  //           ref.read(receiverStatusProvider.notifier).state = GrpcStreamStatus.disconnected;
  //           log('Stream closed');
  //         },
  //       );
  //
  //   // 3️⃣ Initial subscribe / hello
  //   controller.add(ShareDataRequest());
  //
  //   // 4️⃣ Heartbeat (prevents 10s disconnect)
  //   Timer.periodic(const Duration(seconds: 5), (_) {
  //     controller.add(ShareDataRequest());
  //   });
  // }

  // late ShareDataReceiver receiver;

  Future<void> initReceiverOld() async {
    // final receiveData = ref.read(receiverDataProvider);
    // if (receiveData == null) return;
    //
    // receiver = ShareDataReceiver(
    //   url: receiveData.url,
    //   token: receiveData.token,
    //   yourId: receiveData.yourId,
    //   onMessage: (msg) {
    //     // if(msg.hasResponse()){
    //     //   log("msg has response ${msg.response.runtimeType}");
    //     // }
    //     try{
    //       if(msg.command=="connect"){
    //         SenderData senderData = SenderData.fromJson(jsonDecode(msg.data));
    //         ref.read(senderDataProvider.notifier).update((s)=>senderData);
    //         log("we set sender data");
    //       }else if(msg.command =="disconnect"){
    //         ref.read(senderDataProvider.notifier).update((s)=>null);
    //       }else if(msg.command =="data"){
    //         Map<String,dynamic> data = jsonDecode(msg.data.toString())["response"];
    //         RefHistory his = RefHistory.fromJson(data);
    //         CurrentStatus status = CurrentStatus.fromJson(data["result"]);
    //         String? refCode = data["refCode"]?.toString();
    //         String? showCode = data["showCode"]?.toString();
    //         getIt<PerformanceController>().fillReportWithRefHistory(his, refCode, showCode, status);
    //         log("his ${his.showCode}");
    //         if(!navigation.context.isDesktop){
    //           goNamed(Routes.resultReport);
    //         }
    //       }
    //
    //
    //     }catch(e){
    //
    //         log("e ${e.runtimeType}  ${e}");
    //         if(e is Error){
    //           log(e.stackTrace.toString());
    //         }
    //     }
    //     log('Response: ${msg}');
    //   },
    // );
    //
    // receiver.statusStream.listen((s) {
    //   ref.read(receiverStatusProvider.notifier).state = s;
    // });
    //
    // await receiver.start();
  }

  Future<void> initReceiver() async {
    final receiveData = ref.read(receiverDataProvider);
    if (receiveData == null) return;
    log("1");
    await ReceiverSocket.connect(receiveData);

    log("2");
  }

  Future<void> sendToReceiver({required String receiverId}) async {
    void msg;
    SendToReceiverUseCase sendToReceiverUseCase = SendToReceiverUseCase();
    SendToReceiverRequest sendToReceiverRequest = SendToReceiverRequest(receiverId: receiverId);
    final result = await sendToReceiverUseCase(request: sendToReceiverRequest);

    switch (result) {
      case Err<SendToReceiverResponse>():
        FailureHandler.handle(result.error);

      case Ok<SendToReceiverResponse>():
        final r = result.value;
    }

    return msg;
  }

  Future<void> reconnect() async {
    // receiver.reconnectNow();
    await ReceiverSocket.reconnect();

  }

  Future<void> callIt({required String receiverId}) async {
    final controller = StreamController<ShareDataRequest>();
    controller.add(ShareDataRequest());
  }

  Future<void> disconnect() async {
    await ReceiverSocket.disconnect();

    // receiver.disconnect();
  }
}
