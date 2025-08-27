import '../usecases/send_logs_usecase.dart';

abstract class MrzReaderDataSourceInterface {
  Future<SendLogsResponse> sendLogs({required SendLogsRequest request});
}