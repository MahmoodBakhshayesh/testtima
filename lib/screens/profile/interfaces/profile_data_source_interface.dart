import '../usecases/edit_profile_usecase.dart';

abstract class ProfileDataSourceInterface {
  Future<EditProfileResponse> editProfile({required EditProfileRequest request});
}