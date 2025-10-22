import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../core/data_base/local_data_base.dart';
import '../../../core/interface_implementations/parser_imp.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../initialize.dart';
import '../interfaces/logs_data_source_interface.dart';
import '../usecases/get_logs_usecase.dart';
import 'logs_local_ds.dart';

class LogsRemoteDataSource implements LogsDataSourceInterface {
  final LogsLocalDataSource localDataSource = LogsLocalDataSource();
  final NetworkManagerImp networkManager = NetworkManagerImp();

  LogsRemoteDataSource();

  @override
  Future<GetLogsResponse> getLogs({required GetLogsRequest request}) async {
    String api = "$apiVersion/report";
    ResponseInterface res = await networkManager.get(api);
    GetLogsResponse response = await Parser().parse(GetLogsResponse.fromResponse, res, executionReq: request);
    return response;
  }
}
