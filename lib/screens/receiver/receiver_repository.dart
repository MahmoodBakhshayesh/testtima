import '../../core/interface_implementations/network_info_imp.dart';
import '../../core/interfaces/exception_int.dart';
import '../../core/interfaces/failures_int.dart';
import '../../core/interfaces/result_int.dart';
import '../../initialize.dart';
import 'interfaces/receiver_repository_interface.dart';
import 'data_sources/receiver_local_ds.dart';
import 'data_sources/receiver_remote_ds.dart';
import 'usecases/get_receiver_qr_usecase.dart';
import 'usecases/send_to_receiver_usecase.dart';

class ReceiverRepository implements ReceiverRepositoryInterface {
  final ReceiverRemoteDataSource receiverRemoteDataSource = ReceiverRemoteDataSource();
  final ReceiverLocalDataSource receiverLocalDataSource = ReceiverLocalDataSource();
  final NetworkInfoImp networkInfo = getIt<NetworkInfoImp>();

  ReceiverRepository();

  @override
  Future<Result<GetReceiverQrResponse>> getReceiverQr(GetReceiverQrRequest request) async {
    try {
      GetReceiverQrResponse getReceiverQrResponse;
      if (await networkInfo.isConnected) {
        getReceiverQrResponse = await receiverRemoteDataSource.getReceiverQr(request: request);
      } else {
        getReceiverQrResponse = await receiverLocalDataSource.getReceiverQr(request: request);
      }
      return Result.ok(getReceiverQrResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }


    @override
      Future<Result<SendToReceiverResponse>> sendToReceiver(SendToReceiverRequest request) async {
        try {
          SendToReceiverResponse sendToReceiverResponse;
          if (await networkInfo.isConnected) {
            sendToReceiverResponse = await receiverRemoteDataSource.sendToReceiver(request: request);
          } else {
            sendToReceiverResponse = await receiverLocalDataSource.sendToReceiver(request: request);
          }
          return Result.ok(sendToReceiverResponse);
        } on AppException catch (e) {
          return Result.error(ServerFailure.fromAppException(e));
        }
      }
}
