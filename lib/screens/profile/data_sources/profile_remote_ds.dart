import '../../../core/interface_implementations/network_manager_imp.dart';
import '../../../core/data_base/local_data_base.dart';
import '../../../core/interface_implementations/parser_imp.dart';
import '../../../core/interfaces/response_int.dart';
import '../interfaces/profile_data_source_interface.dart';
import '../usecases/edit_profile_usecase.dart';
import 'profile_local_ds.dart';

class ProfileRemoteDataSource implements ProfileDataSourceInterface {
  final ProfileLocalDataSource localDataSource = ProfileLocalDataSource();
  final NetworkManagerImp networkManager = NetworkManagerImp();

  ProfileRemoteDataSource();

  @override
  Future<EditProfileResponse> editProfile({required EditProfileRequest request}) async {
    String api = '/user';
    ResponseInterface res = await networkManager.put(api: api,request);
    EditProfileResponse response = await Parser().parse(EditProfileResponse.fromResponse, res, executionReq: request);
    return response;
  }
}
