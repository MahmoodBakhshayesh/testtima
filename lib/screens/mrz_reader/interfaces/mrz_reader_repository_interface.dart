import 'package:dartz/dartz.dart';

import '../../../core/interfaces/result_int.dart';
import '../usecases/send_logs_usecase.dart';


abstract class MrzReaderRepositoryInterface {
  Future<Result<SendLogsResponse>> sendLogs(SendLogsRequest request);
}