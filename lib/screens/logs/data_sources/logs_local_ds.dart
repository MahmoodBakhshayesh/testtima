import 'package:abds/screens/logs/usecases/get_logs_usecase.dart';

import '../../../core/data_base/local_data_base.dart';
import '../../../initialize.dart';
import '../interfaces/logs_data_source_interface.dart';

class LogsLocalDataSource implements LogsDataSourceInterface {
  final LocalDataBase localDataSource = getIt<LocalDataBase>();
  LogsLocalDataSource();

  @override
  Future<GetLogsResponse> getLogs({required GetLogsRequest request}) {
    // TODO: implement getLogs
    throw UnimplementedError();
  }



}
