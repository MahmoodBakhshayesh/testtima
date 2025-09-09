import 'package:abds/screens/performance/usecases/get_report_usecase.dart';
import 'package:logging/logging.dart';
import '../../core/classes/performance_log_class.dart';
import '../../core/interfaces/controller_int.dart';
import '../../core/interfaces/result_int.dart';
import '../../core/utils_and_services/handlers/failure_handler.dart';


class PerformanceController extends ControllerInterface {
  final _log = Logger('PerformanceController');


    Future<PerformanceLog?> getPerformanceLog({DateTime? fromDate,DateTime? toDate,String? from,String? to}) async {
        PerformanceLog? log;
        GetReportUseCase getPerformanceLogUseCase = GetReportUseCase();
        GetReportRequest getReportRequest = GetReportRequest(from: from,to: to,fromDate: fromDate,toDate: toDate);
        final result = await getPerformanceLogUseCase(request: getReportRequest);

        switch (result) {
          case Err<GetReportResponse>():
            FailureHandler.handle(result.error);

          case Ok<GetReportResponse>():
            final r = result.value;
            log =r.performanceLog;
        }

        return log;
      }
}
