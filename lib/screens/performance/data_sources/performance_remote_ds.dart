import 'package:artemis_utils/artemis_utils.dart';

import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../core/data_base/local_data_base.dart';
import '../../../core/interface_implementations/parser_imp.dart';
import '../../../core/interfaces/response_int.dart';
import '../interfaces/performance_data_source_interface.dart';
import '../usecases/get_report_usecase.dart';
import 'performance_local_ds.dart';

class PerformanceRemoteDataSource implements PerformanceDataSourceInterface {
  final PerformanceLocalDataSource localDataSource = PerformanceLocalDataSource();
  final NetworkManagerImp networkManager = NetworkManagerImp();

  PerformanceRemoteDataSource();

  @override
  Future<GetReportResponse> getReport({required GetReportRequest request}) async {
    String api = "/report?${request.fromDate==null?'':'startDT${request.fromDate.format_yyyyMMdd}&'}${request.toDate==null?'':'endDT${request.toDate.format_yyyyMMdd}&'}${request.from==null?'':'from${request.from}&'}${request.to==null?'':'to${request.to}'}";
    ResponseInterface res = await networkManager.get(api);
    GetReportResponse response = await Parser().parse(GetReportResponse.fromResponse, res, executionReq: request);
    return response;
  }
}
