import '../usecases/get_ref_code_log_usecase.dart';

abstract class HomeDataSourceInterface {
  Future<GetRefCodeLogResponse> getRefCodeLog({required GetRefCodeLogRequest request});
}