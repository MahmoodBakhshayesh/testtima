import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:flutter/material.dart';
import '../../../core/interfaces/failures_int.dart';
import '../../../core/interfaces/request_int.dart';
import '../../../core/interfaces/response_int.dart';
import '../../../core/interfaces/result_int.dart';
import '../../../core/interfaces/usecase_int.dart';
import '../profile_repository.dart';

class EditProfileUseCase extends UseCase<EditProfileResponse, EditProfileRequest> {
  EditProfileUseCase();

  @override
  Future<Result<EditProfileResponse>> call({required EditProfileRequest request}) {
    if (request.validate() != null) return Future(() => Result.error(request.validate()!));
    ProfileRepository repository = ProfileRepository();
    return repository.editProfile(request);
  }
}

class EditProfileRequest extends RequestInterface {
  final Map<String,dynamic> profile;

  EditProfileRequest({required this.profile});

  @override
  Map<String, dynamic> toJson() => profile;

  Failure? validate() {
    return null;
  }
}

class EditProfileResponse extends ResponseInterface {
  final String msg;

  EditProfileResponse({required super.status, required super.message, required this.msg}) : super(body: {"message": msg});

  factory EditProfileResponse.fromResponse(ResponseInterface res) => EditProfileResponse(status: res.status, message: res.message, msg: res.message);
}
