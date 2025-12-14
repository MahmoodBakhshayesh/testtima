import '../../core/interface_implementations/network_info_imp.dart';
import '../../core/interfaces/exception_int.dart';
import '../../core/interfaces/failures_int.dart';
import '../../core/interfaces/result_int.dart';
import '../../initialize.dart';
import 'interfaces/sender_repository_interface.dart';
import 'data_sources/sender_local_ds.dart';
import 'data_sources/sender_remote_ds.dart';
import 'usecases/connect_to_receiver_usecase.dart';
import 'usecases/disconnect_from_receiver_usecase.dart';

class SenderRepository implements SenderRepositoryInterface {
  final SenderRemoteDataSource senderRemoteDataSource = SenderRemoteDataSource();
  final SenderLocalDataSource senderLocalDataSource = SenderLocalDataSource();
  final NetworkInfoImp networkInfo = getIt<NetworkInfoImp>();

  SenderRepository();

  @override
  Future<Result<DisconnectFromReceiverResponse>> disconnectFromReceiver(DisconnectFromReceiverRequest request) async {
    try {
      DisconnectFromReceiverResponse disconnectFromReceiverResponse;
      if (await networkInfo.isConnected) {
        disconnectFromReceiverResponse = await senderRemoteDataSource.disconnectFromReceiver(request: request);
      } else {
        disconnectFromReceiverResponse = await senderLocalDataSource.disconnectFromReceiver(request: request);
      }
      return Result.ok(disconnectFromReceiverResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }

  @override
  Future<Result<ConnectToReceiverResponse>> connectToReceiver(ConnectToReceiverRequest request) async {
    try {
      ConnectToReceiverResponse connectToReceiverResponse;
      if (await networkInfo.isConnected) {
        connectToReceiverResponse = await senderRemoteDataSource.connectToReceiver(request: request);
      } else {
        connectToReceiverResponse = await senderLocalDataSource.connectToReceiver(request: request);
      }
      return Result.ok(connectToReceiverResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }
}
