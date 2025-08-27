import 'package:abds/screens/profile/usecases/edit_profile_usecase.dart';

import '../../../core/data_base/local_data_base.dart';
import '../../../initialize.dart';
import '../interfaces/profile_data_source_interface.dart';

class ProfileLocalDataSource implements ProfileDataSourceInterface {
  final LocalDataBase localDataSource = getIt<LocalDataBase>();
  ProfileLocalDataSource();

  @override
  Future<EditProfileResponse> editProfile({required EditProfileRequest request}) {
    // TODO: implement editProfile
    throw UnimplementedError();
  }



}
