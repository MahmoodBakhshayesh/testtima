import '../../../core/data_base/local_data_base.dart';
import '../../../initialize.dart';
import '../interfaces/result_report_data_source_interface.dart';

class ResultReportLocalDataSource implements ResultReportDataSourceInterface {
  final LocalDataBase localDataSource = getIt<LocalDataBase>();
  ResultReportLocalDataSource();



}
