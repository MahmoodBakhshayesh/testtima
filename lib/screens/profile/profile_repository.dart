import '../../core/interface_implementations/network_info_imp.dart';
import '../../core/interfaces/exception_int.dart';
import '../../core/interfaces/failures_int.dart';
import '../../core/interfaces/result_int.dart';
import '../../initialize.dart';
import 'interfaces/profile_repository_interface.dart';
import 'data_sources/profile_local_ds.dart';
import 'data_sources/profile_remote_ds.dart';
import 'usecases/edit_profile_usecase.dart';

class ProfileRepository implements ProfileRepositoryInterface {
  final ProfileRemoteDataSource profileRemoteDataSource = ProfileRemoteDataSource();
  final ProfileLocalDataSource profileLocalDataSource = ProfileLocalDataSource();
  final NetworkInfoImp networkInfo = getIt<NetworkInfoImp>();

  ProfileRepository();

  @override
  Future<Result<EditProfileResponse>> editProfile(EditProfileRequest request) async {
    try {
      EditProfileResponse editProfileResponse;
      if (await networkInfo.isConnected) {
        editProfileResponse = await profileRemoteDataSource.editProfile(request: request);
      } else {
        editProfileResponse = await profileLocalDataSource.editProfile(request: request);
      }
      return Result.ok(editProfileResponse);
    } on AppException catch (e) {
      return Result.error(ServerFailure.fromAppException(e));
    }
  }
}
