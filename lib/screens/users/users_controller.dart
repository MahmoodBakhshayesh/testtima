import 'dart:developer';
import 'dart:typed_data';

import 'package:abds/core/extenstions/context_exp.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';
import '../../core/classes/people_class.dart';
import '../../core/interfaces/controller_int.dart';
import '../../core/interfaces/failures_int.dart';
import '../../core/interfaces/result_int.dart';
import '../../core/navigation/routes.dart';
import '../../core/utils_and_services/handlers/failure_handler.dart';
import '../../core/utils_and_services/timatic/src/models/auth_response.dart';
import '../login/login_state.dart';
import 'dialogs/edit_user_dialog.dart';
import 'usecases/edit_user_usecase.dart';
import 'usecases/get_users_usecase.dart';
import 'users_state.dart';

class UsersController extends ControllerInterface {
  final _log = Logger('UsersController');

  void showAddUserDialog() {
    navigation.goNamed(Routes.addUser);
  }

  Future<List<People>?> getUserList() async {
    log(ref.read(userProvider)?.token.toString()??'');
    List<People>? peopleList;
    GetUserListUseCase getUserListUseCase = GetUserListUseCase();
    GetUserListRequest getUserListRequest = GetUserListRequest();
    ref.read(loadingUsersProvider.notifier).update((s) => true);
    final result = await getUserListUseCase(request: getUserListRequest);
    ref.read(loadingUsersProvider.notifier).update((s) => false);

    switch (result) {
      case Err<GetUserListResponse>():
        FailureHandler.handle(result.error);

      case Ok<GetUserListResponse>():
        final r = result.value;
        peopleList = r.peoples;
        ref.read(peopleListProvider.notifier).update((s) => r.peoples);
    }

    return peopleList;
  }

  void showEditUserDialog(People people) {
    navigation.openDialog(dialog: EditUserDialog(user: people));
  }

  Future<People?> updateUser({required People user, required bool enable, required List<UserPermission> permissions}) async {
    People? updated;
    EditUserUseCase updateUserUseCase = EditUserUseCase();
    EditUserRequest editUserRequest = EditUserRequest(people: user, active: enable, updatedPermissions: permissions);
    final result = await updateUserUseCase(request: editUserRequest);

    switch (result) {
      case Err<EditUserResponse>():
        FailureHandler.handle(result.error);

      case Ok<EditUserResponse>():
        final r = result.value;
        updated = People.fromJson(user.toJson());
        updated.enable = enable;
        updated.permissions = permissions;

        int index = ref.read(peopleListProvider).indexWhere((a) => a.uId == updated!.uId);
        final copy = [...ref.read(peopleListProvider)];
        copy[index] = updated;
        ref.read(peopleListProvider.notifier).update((s) => copy);
    }

    return updated;
  }

  Future<Uint8List?> loadUserAvatar(People? people) async {
    final photo = await userGetPhoto(people);
    return photo;
  }

  Future<Uint8List?> userGetPhoto(People? people) async {
    Uint8List? photo;
    try {
      final serverAddress = ref.watch(selectedServerProvider)!.apiAddress;
      String apiAddress = "$serverAddress/user/image";
      if (people != null) {
        apiAddress = "$serverAddress/user/myUsers/image/${people!.username}";
        // log(apiAddress);
        // log(people.hasImage.toString());
      }
      Dio dio = Dio(BaseOptions(headers: {"ContentType": "application-json", "Authorization": "Bearer ${ref.read(userProvider)!.token}"}));
      String api = apiAddress;
      final response = await dio.get<List<int>>(api, options: Options(responseType: ResponseType.bytes));

      photo = Uint8List.fromList(response.data!);
    } catch (e) {
      log("$e");
    }

    return photo;
  }

  Uint8List hexToBytes(String hex) {
    final buffer = StringBuffer();
    for (int i = 0; i < hex.length; i += 2) {
      buffer.writeCharCode(int.parse(hex.substring(i, i + 2), radix: 16));
    }
    return Uint8List.fromList(buffer.toString().codeUnits);
  }

  Future<void> setAvatar() async {
    // return;
    var updatingAvatarPN = ref.read(updatingAvatarProvider.notifier);
    try {
      updatingAvatarPN.update((state) => true);
      final ImagePicker picker = ImagePicker();
      picker.supportsImageSource(ImageSource.gallery);
      final XFile? image = await picker.pickImage(source: ImageSource.gallery, requestFullMetadata: false, imageQuality: 20);
      if (image == null) {
        updatingAvatarPN.update((state) => false);
        return;
      }
      int imageSize = await image.length();

      final kb = imageSize / 1024;
      final mb = kb / 1024;
      log("image size is $mb mb");
      if (mb > 5) {
        FailureHandler.handle(ValidationFailure(code: -1, msg: "Image Size is more than 5mb!\nUse smaller image.", traceMsg: "Image Size is more than 5mb"));
        updatingAvatarPN.update((state) => false);
        return;
      }
      await uploadImage(image);
      await evictImage();
      updatingAvatarPN.update((state) => false);
      return;
    } catch (e) {
      log("upload erro ${e.toString()}");
      updatingAvatarPN.update((state) => false);
    }
  }

  Future<void> evictImage() async {
    String url = "${ref.read(selectedServerProvider).apiAddress}/user/image";
    await CachedNetworkImage.evictFromCache(url);
    final NetworkImage provider = NetworkImage(url);
    await provider.evict();
  }

  Future<void> uploadImage(XFile imageFile) async {
    final dio = Dio();

    final fileName = imageFile.path.split('/').last;

    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
        contentType: MediaType('image', 'jpeg'), // Or 'image', 'webp', etc.
      ),
    });

    final serverAddress = ref.watch(selectedServerProvider)!.apiAddress;
    String apiAddress = "$serverAddress/user/image";
    // log(apiAddress);
    try {
      final dio = Dio();
      final response = await dio.put(
        apiAddress,
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data', "Authorization": "Bearer ${ref.read(userProvider)!.token}"}),
      );

      if (response.statusCode == 200) {
        log('Upload success: ${response.data}');
        // evictImage();
        ref
            .read(userProvider.notifier)
            .update(
              (s) => s?.copyWith(
                profile: Profile(username: s.profile.username, email: s.profile.email, firstname: s.profile.firstname, middlename: s.profile.middlename, lastname: s.profile.lastname, hasImage: true),
              ),
            );
      }
    } catch (e) {
      log('Upload failed: $e');
    }
  }

  Future<void> deleteAvatar() async {
    // return;
    var updatingAvatarPN = ref.read(updatingAvatarProvider.notifier);
    try {
      updatingAvatarPN.update((state) => true);
      final serverAddress = ref.watch(selectedServerProvider)!.apiAddress;
      String apiAddress = "$serverAddress/user/image";
      // log(apiAddress);
      final dio = Dio();

      final response = await dio.delete(apiAddress, options: Options(headers: {'Content-Type': 'multipart/form-data', "Authorization": "Bearer ${ref.read(userProvider)!.token}"}));
      if (response.statusCode == 200) {
        log('Upload success: ${response.data}');
        ref
            .read(userProvider.notifier)
            .update(
              (s) => s?.copyWith(
                profile: Profile(username: s.profile.username, email: s.profile.email, firstname: s.profile.firstname, middlename: s.profile.middlename, lastname: s.profile.lastname, hasImage: false),
              ),
            );
        await evictImage();
      }

      log('Delete success: ${response.data}');
    } catch (e) {
      log('Upload failed: $e');
    }
    updatingAvatarPN.update((state) => false);
  }
}
