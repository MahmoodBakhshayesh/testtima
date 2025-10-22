import 'package:abds/initialize.dart';
import 'package:abds/screens/add_user/usecases/add_user_usecase.dart';

import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../core/data_base/local_data_base.dart';
import '../../../core/interface_implementations/parser_imp.dart';
import '../../../core/interfaces/response_int.dart';
import '../interfaces/add_user_data_source_interface.dart';
import 'add_user_local_ds.dart';

class AddUserRemoteDataSource implements AddUserDataSourceInterface {
  final AddUserLocalDataSource localDataSource = AddUserLocalDataSource();
  final NetworkManagerImp networkManager = NetworkManagerImp();
  AddUserRemoteDataSource();

  @override
  Future<AddUserResponse> addUser({required AddUserRequest request}) async {
    String api = '$apiVersion/user';
    ResponseInterface res = await networkManager.post(request,api: api);
    AddUserResponse response = await Parser().parse(AddUserResponse.fromResponse, res, executionReq: request);
    return response;
  }
}
