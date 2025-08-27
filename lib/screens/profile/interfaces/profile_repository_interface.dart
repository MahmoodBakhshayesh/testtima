import 'package:dartz/dartz.dart';

import '../../../core/interfaces/result_int.dart';
import '../usecases/edit_profile_usecase.dart';


abstract class ProfileRepositoryInterface {
  Future<Result<EditProfileResponse>> editProfile(EditProfileRequest request);
}