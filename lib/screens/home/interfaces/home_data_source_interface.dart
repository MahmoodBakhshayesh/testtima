import '../usecases/get_ref_code_log_usecase.dart';
import '../usecases/get_supervisors_usecase.dart';

abstract class HomeDataSourceInterface {
  Future<GetRefCodeLogResponse> getRefCodeLog({required GetRefCodeLogRequest request});
  Future<GetSupervisorsResponse> getSupervisors({required GetSupervisorsRequest request});
}