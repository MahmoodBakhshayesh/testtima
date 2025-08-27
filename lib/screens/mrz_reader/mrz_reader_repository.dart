import '../../core/interface_implementations/network_info_imp.dart';
import '../../core/interfaces/exception_int.dart';
import '../../core/interfaces/failures_int.dart';
import '../../core/interfaces/result_int.dart';
import '../../initialize.dart';
import 'interfaces/mrz_reader_repository_interface.dart';
import 'data_sources/mrz_reader_local_ds.dart';
import 'data_sources/mrz_reader_remote_ds.dart';
import 'usecases/send_logs_usecase.dart';

class MrzReaderRepository implements MrzReaderRepositoryInterface {
  final MrzReaderRemoteDataSource mrzReaderRemoteDataSource = MrzReaderRemoteDataSource();
  final MrzReaderLocalDataSource mrzReaderLocalDataSource = MrzReaderLocalDataSource();
  final NetworkInfoImp networkInfo = getIt<NetworkInfoImp>();

  MrzReaderRepository();

    @override
      Future<Result<SendLogsResponse>> sendLogs(SendLogsRequest request) async {
        try {
          SendLogsResponse sendLogsResponse;
          if (await networkInfo.isConnected) {
            sendLogsResponse = await mrzReaderRemoteDataSource.sendLogs(request: request);
          } else {
            sendLogsResponse = await  mrzReaderLocalDataSource.sendLogs(request: request);
          }
          return Result.ok(sendLogsResponse);
        } on AppException catch (e) {
          return Result.error(ServerFailure.fromAppException(e));
        }
      }
}
