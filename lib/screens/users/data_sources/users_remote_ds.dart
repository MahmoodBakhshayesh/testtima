import 'dart:developer';

import '../../../core/classes/basic_class.dart';
import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../core/data_base/local_data_base.dart';
import '../../../core/interface_implementations/parser_imp.dart';
import '../../../core/interface_implementations/response_imp.dart';
import '../../../core/interfaces/response_int.dart';
import '../interfaces/users_data_source_interface.dart';
import '../usecases/edit_user_usecase.dart';
import '../usecases/get_users_usecase.dart';
import 'users_local_ds.dart';

class UsersRemoteDataSource implements UsersDataSourceInterface {
  final UsersLocalDataSource localDataSource = UsersLocalDataSource();
  final NetworkManagerImp networkManager = NetworkManagerImp();
  UsersRemoteDataSource();

  @override
  Future<GetUserListResponse> getUserList({required GetUserListRequest request}) async {
    String api = '/user/myUsers';
    try {
      ResponseInterface res = await networkManager.get(api);
      List<dynamic> fixed = res.body;
      for (var p in fixed) {
        final List<dynamic> fixedPermissions = p["permissions"]??[];
        for(var fp in fixedPermissions){
          Map<String,dynamic> fixedPermission = Map<String,dynamic>.from(fp);
          fixedPermission["allPermissions"] = BasicClass.constData.userPermissionAttributes.toJson();
          fp["allPermissions"] = BasicClass.constData.userPermissionAttributes.toJson();
          fixedPermission.forEach((k,v){
            if(v is List<dynamic>){
              for (var a in v) {
                a["allPermissions"] = BasicClass.constData.userPermissionAttributes.toJson();
              }
            }
          });
        }


        // for (var ap in (p["permission"]["airlines"] as List<dynamic>)) {
        //   ap["allPermissions"] = BasicClass.constData.userPermissionAttributes.toJson();
        // }
        // for (var ap in (p["permission"]["airports"] as List<dynamic>)) {
        //   ap["allPermissions"] = BasicClass.constData.userPermissionAttributes.toJson();
        // }
        // for (var ap in (p["permission"]["handlings"] as List<dynamic>)) {
        //   ap["allPermissions"] = BasicClass.constData.userPermissionAttributes.toJson();
        // }
      }
      final fixedRes = ResponseImplementation(message: res.message, body: fixed, status: res.status);
      GetUserListResponse response = await Parser().parse(GetUserListResponse.fromResponse, fixedRes, executionReq: request);
      return response;
    } catch (e) {
      log("$e");
      if (e is Error) {
        log(e.stackTrace.toString());
      }
      rethrow;
    }
  }

  @override
  Future<EditUserResponse> editUser({required EditUserRequest request}) async {
    String api = '/user/myUsers/${request.people.uId}';
    ResponseInterface res = await networkManager.put(request, api: api);
    EditUserResponse response = await Parser().parse(EditUserResponse.fromResponse, res, executionReq: request);
    return response;
  }
}
