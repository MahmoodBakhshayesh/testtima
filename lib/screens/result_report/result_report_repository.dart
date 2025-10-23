import '../../core/interface_implementations/network_info_imp.dart';
import '../../initialize.dart';
import 'interfaces/result_report_repository_interface.dart';
import 'data_sources/result_report_local_ds.dart';
import 'data_sources/result_report_remote_ds.dart';

class ResultReportRepository implements ResultReportRepositoryInterface {
  final ResultReportRemoteDataSource resultReportRemoteDataSource = ResultReportRemoteDataSource();
  final ResultReportLocalDataSource resultReportLocalDataSource = ResultReportLocalDataSource();
  final NetworkInfoImp networkInfo = getIt<NetworkInfoImp>();

  ResultReportRepository();
}
