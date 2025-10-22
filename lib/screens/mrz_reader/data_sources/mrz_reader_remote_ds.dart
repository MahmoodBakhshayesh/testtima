import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../core/data_base/local_data_base.dart';
import '../../../core/interface_implementations/parser_imp.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../initialize.dart';
import '../interfaces/mrz_reader_data_source_interface.dart';
import '../usecases/send_logs_usecase.dart';
import 'mrz_reader_local_ds.dart';

class MrzReaderRemoteDataSource implements MrzReaderDataSourceInterface {
  final MrzReaderLocalDataSource localDataSource = MrzReaderLocalDataSource();
  final NetworkManagerImp networkManager = NetworkManagerImp();

  MrzReaderRemoteDataSource();

  @override
  Future<SendLogsResponse> sendLogs({required SendLogsRequest request}) async {
    String api = '$apiVersion/mrzLog';
    // String api = '/mrzReader';
    ResponseInterface res = await networkManager.post(request, api: api);
    SendLogsResponse response = await Parser().parse(SendLogsResponse.fromResponse, res, executionReq: request);
    return response;
  }
}
