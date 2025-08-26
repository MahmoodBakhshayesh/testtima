import '../../core/interface_implementations/network_info_imp.dart';
import '../../core/interfaces/exception_int.dart';
import '../../core/interfaces/failures_int.dart';
import '../../core/interfaces/result_int.dart';
import '../../initialize.dart';
import 'interfaces/logs_repository_interface.dart';
import 'data_sources/logs_local_ds.dart';
import 'data_sources/logs_remote_ds.dart';
import 'usecases/get_logs_usecase.dart';

class LogsRepository implements LogsRepositoryInterface {
  final LogsRemoteDataSource logsRemoteDataSource = LogsRemoteDataSource();
  final LogsLocalDataSource logsLocalDataSource = LogsLocalDataSource();
  final NetworkInfoImp networkInfo = getIt<NetworkInfoImp>();

  LogsRepository();

  @override
  Future<Result<GetLogsResponse>> getLogs(GetLogsRequest request) async {
    try {
      GetLogsResponse getLogsResponse;
      if (await networkInfo.isConnected) {
        getLogsResponse = await logsRemoteDataSource.getLogs(request: request);
      } else {
        getLogsResponse = await logsLocalDataSource.getLogs(request: request);
      }
      return Result.ok(getLogsResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }
}
