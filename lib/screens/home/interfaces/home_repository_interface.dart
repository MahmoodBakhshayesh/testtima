import 'package:dartz/dartz.dart';
import '../../../core/interfaces/result_int.dart';
import '../usecases/get_ref_code_log_usecase.dart';

abstract class HomeRepositoryInterface {
  Future<Result<GetRefCodeLogResponse>> getRefCodeLog(GetRefCodeLogRequest request);
}