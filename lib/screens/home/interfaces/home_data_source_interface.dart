import '../usecases/get_notif_count_usecase.dart';
import '../usecases/get_ref_code_log_usecase.dart';
import '../usecases/get_supervisors_usecase.dart';

abstract class HomeDataSourceInterface {
  Future<GetRefCodeLogResponse> getRefCodeLog({required GetRefCodeLogRequest request});
  Future<GetSupervisorsResponse> getSupervisors({required GetSupervisorsRequest request});
  Future<GetNotifCountResponse> getNotifCount({required GetNotifCountRequest request});
}