import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:abds/screens/login/login_state.dart';
import 'package:artemis_ui_kit/artemis_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/constants/ui.dart';
import '../../widgets/DotButton.dart';
import '../../widgets/MyButton.dart';
import '../../widgets/user_avatar.dart';
import '../users/users_controller.dart';
import 'profile_controller.dart';
import 'profile_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';

class ProfileViewPhone extends ConsumerStatefulWidget {
  static ProfileController myProfileController = getIt<ProfileController>();

  const ProfileViewPhone({super.key});

  @override
  ConsumerState<ProfileViewPhone> createState() => _ProfileViewPhoneState();
}

class _ProfileViewPhoneState extends ConsumerState<ProfileViewPhone> {
  static ProfileController myProfileController = getIt<ProfileController>();

  @override
  Widget build(BuildContext context) {
    final Profile? profile = ref.watch(userProvider)?.profile;
    if(profile == null){
      return SizedBox();
    }
    return Scaffold(
      appBar: ProfileAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(context.width * .5),
                      child: Container(
                        width: context.width * 0.7,
                        height: context.width * 0.7,
                        decoration: BoxDecoration(color: Colors.black12),
                        child: UserAvatar(url: '', canEdit: true, hasImage: ref.watch(userProvider)?.profile.hasImage ?? false),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Row(
                        children: [
                          const SizedBox(width: 12),
                          profile.hasImage
                              ? DotButton(
                                  icon: Icons.delete,
                                  onPressed: () async {
                                    await getIt<UsersController>().deleteAvatar();
                                  },
                                  size: 50,
                                  color: Colors.red,
                                )
                              : SizedBox(),
                          Spacer(),
                          const SizedBox(width: 12),
                          DotButton(
                            icon: Icons.add_photo_alternate,
                            onPressed: () async {
                              await getIt<UsersController>().setAvatar();
                            },
                            size: 50,
                          ),
                          const SizedBox(width: 12),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      Column(
                        spacing: 8,
                        children: [
                          ArtemisCardField(title: "Username", value: profile.username ?? '-'),
                          ArtemisCardField(title: "Email", value: profile.email ?? '-'),
                          ArtemisCardField(title: "First Name", value: profile.firstname ?? '-'),
                          ArtemisCardField(title: "Middle Name", value: profile.middlename ?? '-'),
                          ArtemisCardField(title: "Last Name", value: profile.lastname ?? '-'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 12, right: 12, bottom: 24, top: 12),
            color: MyColors.greyBG,
            child: Row(
              spacing: 12,
              children: [
                Expanded(
                  child: MyButton(label: "Change Password", icon: Icons.password, iconInRight: true, onPressed: () async {
                    myProfileController.changePasswordDialog(profile);
                  }, radius: 12),
                ),
                Expanded(
                  child: MyButton(
                    label: "Edit Info",
                    icon: Icons.edit,
                    iconInRight: true,
                    onPressed: () async {
                      myProfileController.editProfileDialog(profile);
                    },
                    radius: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  static ProfileController myProfileController = getIt<ProfileController>();

  const ProfileAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(108);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: Colors.white,
      alignment: Alignment.center,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      BackButton(),
                      Text("Profile", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                      Spacer(),
                      SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
