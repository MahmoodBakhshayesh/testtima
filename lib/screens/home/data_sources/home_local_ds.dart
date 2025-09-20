import 'dart:developer';
import 'package:abds/screens/home/usecases/get_notif_count_usecase.dart';
import 'package:abds/screens/home/usecases/get_ref_code_log_usecase.dart';
import 'package:abds/screens/home/usecases/get_supervisors_usecase.dart';

import '../../../core/interfaces/local_data_base_int.dart';

import '../../../core/classes/user_class.dart';
import '../../../core/data_base/classes/db_user_class.dart';
import '../../../core/data_base/local_data_base.dart';
import '../../../core/data_base/table_names.dart';
import '../../../initialize.dart';
import '../interfaces/home_data_source_interface.dart';

const String userJsonLocalKey = "UserJson";

class HomeLocalDataSource implements HomeDataSourceInterface {
  final LocalDataSourceInterface localDataSource = getIt<LocalDataBase>();
  HomeLocalDataSource();

  @override
  Future<GetRefCodeLogResponse> getRefCodeLog({required GetRefCodeLogRequest request}) {
    // TODO: implement getRefCodeLog
    throw UnimplementedError();
  }

  @override
  Future<GetSupervisorsResponse> getSupervisors({required GetSupervisorsRequest request}) {
    // TODO: implement getSupervisors
    throw UnimplementedError();
  }

  @override
  Future<GetNotifCountResponse> getNotifCount({required GetNotifCountRequest request}) {
    // TODO: implement getNotifCount
    throw UnimplementedError();
  }



}
