import '../usecases/get_logs_usecase.dart';

abstract class LogsDataSourceInterface {
  Future<GetLogsResponse> getLogs({required GetLogsRequest request});
}