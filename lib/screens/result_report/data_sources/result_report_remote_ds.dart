import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../core/data_base/local_data_base.dart';
import '../interfaces/result_report_data_source_interface.dart';
import 'result_report_local_ds.dart';

class ResultReportRemoteDataSource implements ResultReportDataSourceInterface {
  final ResultReportLocalDataSource localDataSource = ResultReportLocalDataSource();
  final NetworkManagerImp networkManager = NetworkManagerImp();
  ResultReportRemoteDataSource();
}
