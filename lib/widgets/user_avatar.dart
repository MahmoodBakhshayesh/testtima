import 'dart:developer';

import 'package:abds/core/extenstions/context_exp.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../core/classes/basic_class.dart';
import '../core/classes/people_class.dart';
import '../core/constants/ui.dart';
import '../initialize.dart';
import '../screens/login/login_state.dart';
import '../screens/users/users_controller.dart';

class UserAvatar extends ConsumerWidget {
  final People? people;
  final String url;
  final bool canEdit;
  final bool hasImage;

  const UserAvatar({super.key, required this.url, this.canEdit = false, this.hasImage = false, this.people});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool loading = ref.watch(updatingAvatarProvider);
    return GestureDetector(
      onTap: () {
        if (canEdit && people == null) {
          getIt<UsersController>().setAvatar();
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Container(
          decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
          width: 40,
          height: 40,
          child: FittedBox(
            fit: BoxFit.cover,
            child: loading
                ? SpinKitCircle(size: 20, color: context.mainColor)
                : hasImage
                // ? CachedNetworkImage(
                //     imageUrl: url ?? '',
                //     httpHeaders: {"Api-Key": BasicClass.settings.systemSettings.photoApi.key},
                //     placeholder: (_, __) => SpinKitCircle(size: 20, color: context.mainColor),
                //     errorWidget: (_, __, ___) => SizedBox(),
                //   )
                // ? FutureBuilder(
                //     future: getIt<UsersController>().loadUserAvatar(people),
                //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                //       if(snapshot.connectionState != ConnectionState.done){
                //         return SpinKitCircle(size: 20, color: context.mainColor);
                //       }
                //       if(snapshot.data == null){
                //         return GestureDetector(
                //           onTap: (){
                //            // final a =  getIt<UsersController>().userGetPhoto(people);
                //           },
                //           child: Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Icon(
                //               Icons.camera_alt,
                //               color: Colors.white,
                //             ),
                //           ),
                //         );
                //       }
                //
                //       return Image.memory(snapshot.data!);
                //       return SizedBox();
                //     },
                //   )
                ? UserAvatarWithUsername(people: people)
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.camera_alt, color: Colors.white),
                  ),
          ),
        ),
      ),
    );
  }
}

class UserAvatarWithUsername extends ConsumerWidget {
  final People? people;

  const UserAvatarWithUsername({super.key, this.people});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool loading = ref.watch(updatingAvatarProvider);
    String api = '${ref.read(selectedServerProvider).apiAddress}/user/image';
    if (people != null) {
      api = "${ref.read(selectedServerProvider).apiAddress}/user/myUsers/image/${people!.username}";
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Container(
        decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
        width: 25,
        height: 25,
        child: loading
            ? SpinKitCircle(size: 20, color: context.mainColor)
            : CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: api,
                httpHeaders: {"Authorization": "Bearer ${ref.read(userProvider)!.token}"},
                placeholder: (_, __) => FittedBox(
                  fit: BoxFit.fill,
                  child: Text('', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                errorWidget: (_, __, ___) => FittedBox(
                  fit: BoxFit.contain,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Icon(Icons.add_a_photo_sharp, color: Colors.white),
                  ),
                ),
              ),
      ),
    );
  }
}
