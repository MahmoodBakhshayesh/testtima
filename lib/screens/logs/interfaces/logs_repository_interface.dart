import 'package:dartz/dartz.dart';

import '../../../core/interfaces/result_int.dart';
import '../usecases/get_logs_usecase.dart';


abstract class LogsRepositoryInterface {
  Future<Result<GetLogsResponse>> getLogs(GetLogsRequest request);
}