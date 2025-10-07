import 'dart:convert';
import 'dart:developer';

import 'package:abds/core/utils_and_services/timatic/src/models/auth_response.dart';
import 'package:abds/screens/login/login_state.dart';
import 'package:abds/screens/profile/dialogs/change_password_dialog.dart';
import 'package:abds/screens/profile/dialogs/edit_profile_dialog.dart';
import 'package:logging/logging.dart';
import '../../core/interfaces/controller_int.dart';
import '../../core/interfaces/result_int.dart';
import '../../core/utils_and_services/handlers/failure_handler.dart';
import 'usecases/edit_profile_usecase.dart';

class ProfileController extends ControllerInterface {
  final _log = Logger('ProfileController');

  Future<void> editProfileDialog(Profile profile) async {
    navigation.openDialog(dialog: EditProfileDialog(profile: profile));
  }

  Future<Profile?> editProfile(Profile current,Map<String,dynamic> updating,Map<String,dynamic> attributes) async {
    Profile? profile;
    EditProfileUseCase editProfileUseCase = EditProfileUseCase();
    EditProfileRequest editProfileRequest = EditProfileRequest(profile: updating,attributes:attributes);
    final result = await editProfileUseCase(request: editProfileRequest);

    switch (result) {
      case Err<EditProfileResponse>():
        FailureHandler.handle(result.error);

      case Ok<EditProfileResponse>():
        final r = result.value;
        var json = current.toJson();
        updating.forEach((a,k){
          json[a] = k;
        });
        profile = Profile.fromJson(json);
        log("updated ${jsonEncode(profile.toJson())}");
        ref.read(userProvider.notifier).update((s)=>s?.copyWith(profile: profile,attributes: attributes));
    }

    return profile;
  }

  void changePasswordDialog(Profile profile) {
    navigation.openDialog(dialog: ChangePasswordDialog(profile: profile));
  }
}
