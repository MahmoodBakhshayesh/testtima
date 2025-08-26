import 'package:abds/screens/logs/logs_state.dart';
import 'package:abds/screens/logs/usecases/get_logs_usecase.dart';
import 'package:logging/logging.dart';
import '../../core/classes/timatic_log.dart';
import '../../core/interfaces/controller_int.dart';
import '../../core/interfaces/result_int.dart';
import '../../core/utils_and_services/handlers/failure_handler.dart';

class LogsController extends ControllerInterface {
  final _log = Logger('LogsController');

  Future<List<TimaticLog>?> getLogs() async {
    List<TimaticLog>? logList;
    GetLogsUseCase getLogsUseCase = GetLogsUseCase();
    GetLogsRequest getLogsRequest = GetLogsRequest();
    ref.read(logsLoadingProvider.notifier).update((s)=>true);
    final result = await getLogsUseCase(request: getLogsRequest);
    ref.read(logsLoadingProvider.notifier).update((s)=>false);


    switch (result) {
      case Err<GetLogsResponse>():
        FailureHandler.handle(result.error);

      case Ok<GetLogsResponse>():
        final r = result.value;
        ref.read(logsProvider.notifier).update((s)=>r.logs);
    }

    return logList;
  }
}
