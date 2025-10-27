import 'dart:convert';
import 'dart:developer';

import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:abds/screens/login/login_state.dart';
import 'package:artemis_ui_kit/artemis_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/classes/basic_class.dart';
import '../../core/constants/ui.dart';
import '../../core/utils_and_services/icomoon_layered_presets_from_css.dart';
import '../../widgets/DotButton.dart';
import '../../widgets/MyButton.dart';
import '../../widgets/MyDatePicker.dart';
import '../../widgets/MyExpansionTile.dart';
import '../../widgets/MyFieldPicker.dart';
import '../../widgets/MyTextField.dart';
import '../../widgets/MyTextFieldNew.dart';
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
  TextEditingController firstNameC = TextEditingController();
  TextEditingController lastNameC = TextEditingController();
  TextEditingController middleNameC = TextEditingController();
  FocusNode firstNameFN = FocusNode();
  FocusNode lastNameFN = FocusNode();
  FocusNode middleNameFN = FocusNode();
  late Profile profile;
  Map<String, dynamic> attributes = {};

  @override
  void initState() {
    profile = ref.read(userProvider)!.profile;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ref.read(userProvider)!;
      log(jsonEncode(user.attributes));
      BasicClass.constData.data.attribute.where((a) => !a.onlyOwner).forEach((att) {
        if(att.type.toLowerCase() == "string"){
          attributes.putIfAbsent(att.name, ()=>TextEditingController(text: user.attributes[att.name]));
        }else if(att.type.toLowerCase() =="enum"){
          attributes.putIfAbsent(att.name, ()=>user.attributes[att.name]);
        }else if(att.type.toLowerCase() =="date"){
          attributes.putIfAbsent(att.name, ()=>DateTime.tryParse(user.attributes[att.name]));
        }else if(att.type.toLowerCase() =="boolean"){
          attributes.putIfAbsent(att.name, ()=>(user.attributes[att.name])??false);
        }else if(att.type.toLowerCase() =="number"){
          attributes.putIfAbsent(att.name, ()=>TextEditingController(text: user.attributes[att.name]?.toString()));
        }else if(att.type.toLowerCase() =="float"){
          attributes.putIfAbsent(att.name, ()=>TextEditingController(text: user.attributes[att.name]?.toString()));
        }else if(att.type.toLowerCase() =="multiselectlist"){
          attributes.putIfAbsent(att.name, ()=>user.attributes[att.name]??[]);
        }
      });
      firstNameC.text = user.profile.firstname ?? '';
      lastNameC.text = user.profile.lastname ?? '';
      middleNameC.text = user.profile.middlename ?? '';
      setState(() {});
    });

    firstNameC.addListener(() => setState(() {}));
    lastNameC.addListener(() => setState(() {}));
    middleNameC.addListener(() => setState(() {}));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final headerBg = MyColors.green2.withOpacity(0.26);
    final bodyBg = MyColors.green2.withOpacity(0.12);
    final headerBgGrey = MyColors.black.withOpacity(0.08);
    final bodyBgGrey  = MyColors.black.withOpacity(0.12);
    if (profile == null) {
      return SizedBox();
    }
    return Scaffold(
      appBar: ProfileAppBar(),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusGeometry.circular(10)
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        spacing: 12,
                        children: [
                          Row(children: [
                            IcomoonLayeredCss.user_square(),
                            const SizedBox(width: 8),
                            Text("Personal Info",style: TextStyle(fontWeight: FontWeight.bold),)
                          ],),
                          Row(
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(context.width * .5),
                                    child: Container(
                                      width: context.width * 0.2,
                                      height: context.width * 0.2,
                                      decoration: BoxDecoration(color: Colors.black12),
                                      child: UserAvatar(url: '', canEdit: true, hasImage: ref.watch(userProvider)?.profile.hasImage ?? false),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    left: 0,
                                    child: Row(
                                      children: [

                                        profile.hasImage
                                            ? DotButton(
                                          icon: Icons.delete,
                                          onPressed: () async {
                                            await getIt<UsersController>().deleteAvatar();
                                          },
                                          size: 30,
                                          color: Colors.red,
                                          fade: false,
                                          radius: 8,
                                        )
                                            : SizedBox(),
                                        Spacer(),
                                        const SizedBox(width: 12),
                                        DotButton(

                                          icon: Icons.add_photo_alternate,
                                          onPressed: () async {
                                            await getIt<UsersController>().setAvatar();
                                          },
                                          color: Colors.black,
                                          flat: false,
                                          fade: false,
                                          size: 30,
                                          radius: 8,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          MyTextFieldNew(headerBgColor: headerBgGrey, bodyBgColor: bodyBgGrey, label: "Firstname", controller: firstNameC, focusNode: firstNameFN, labelInRow: true),
                          MyTextFieldNew(headerBgColor: headerBgGrey, bodyBgColor: bodyBgGrey, label: "Middle name", controller: middleNameC, focusNode: middleNameFN, labelInRow: true),
                          MyTextFieldNew(headerBgColor: headerBgGrey, bodyBgColor: bodyBgGrey, label: "Lastname", controller: lastNameC, focusNode: lastNameFN, labelInRow: true),
                          Row(
                            children: [

                              MyButton(
                                flat: true,
                                reverse: true,
                                label: "Change Password",
                                icon: Icons.lock,


                                onPressed: () async {
                                  myProfileController.changePasswordDialog(profile);
                                },
                                radius: 12,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  Divider(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      children: [
                        Column(
                          spacing: 8,
                          children: [
                            MyExpansionTile(
                              initiallyExpanded: true,
                              showFooter: false,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
                              collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
                              childrenPadding: EdgeInsets.symmetric(horizontal: 12),
                              backgroundColor: Colors.green.withOpacity(0.08),
                              collapsedBackgroundColor: Colors.green.withOpacity(0.08),
                              tilePadding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                              title: Text("Attributes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              children: BasicClass.constData.data.attribute.where((a) => !a.onlyOwner).map((att) {
                                final headerBg = MyColors.green2.withOpacity(0.26);
                                final bodyBg = MyColors.green2.withOpacity(0.12);
                                if (att.type == "string") {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: MyTextFieldNew(
                                        rowLabelRatio: [4,7],
                                        headerBgColor: headerBg, bodyBgColor: bodyBg,
                                        label: att.title, placeholder: att.title, controller: attributes[att.name]),
                                  );
                                } else if (att.type == "enum") {
                                  final overrideList = BasicClass.constData.data.toJson()["${att.listItemName}"];

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: MyFieldPicker<dynamic>(
                                      items: (overrideList is List) ? overrideList : att.defaultList,
                                      headerBgColor: headerBg,
                                      bodyBgColor: bodyBg,
                                      value: attributes[att.name],
                                      onChange: (a) {
                                        attributes[att.name] = a;
                                        setState(() {});
                                      },
                                      label: att.title,
                                      placeholder: att.title,
                                    ),
                                  );
                                } else if (att.type == "boolean") {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: MyTextFieldNew(headerBgColor: headerBg, bodyBgColor: bodyBg, label: att.title, placeholder: att.title, controller: attributes[att.name]),
                                  );
                                } else if (att.type == "number") {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: MyTextFieldNew(headerBgColor: headerBg, bodyBgColor: bodyBg, label: att.title, placeholder: att.title, controller: attributes[att.name]),
                                  );
                                } else if (att.type == "float") {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: MyTextFieldNew(headerBgColor: headerBg, bodyBgColor: bodyBg, label: att.title, placeholder: att.title, controller: attributes[att.name]),
                                  );
                                } else if (att.type == "date") {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: MyDatePicker(
                                      headerBgColor: headerBg,
                                      bodyBgColor: bodyBg,
                                      value: attributes[att.name],
                                      onChanged: (a) {
                                        attributes[att.name] = a;
                                        setState(() {});
                                      },
                                      label: att.title,
                                      placeholder: att.title,
                                    ),
                                  );
                                }
                                return Container(child: Row(children: [Text("${att.title}")]));
                              }).toList(),
                            ),// ArtemisCardField(title: "Username", value: profile.username ?? '-'),
                            // ArtemisCardField(title: "Email", value: profile.email ?? '-'),
                            // ArtemisCardField(title: "First Name", value: profile.firstname ?? '-'),
                            // ArtemisCardField(title: "Middle Name", value: profile.middlename ?? '-'),
                            // ArtemisCardField(title: "Last Name", value: profile.lastname ?? '-'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 12, right: 12, bottom: 24, top: 12),
            color: MyColors.greyBG,
            child: Row(
              spacing: 12,
              children: [

                Expanded(
                  child: MyButton(
                    label: "Save Changes",
                    icon: Icons.edit,
                    iconInRight: true,
                    onPressed: () async {
                      final attFix = <String, dynamic>{};

                      attributes.forEach((k, v) {
                        final att = BasicClass.constData.data.attribute.firstWhere((a) => a.name == k);
                        if (att.type.toLowerCase() == "string") {
                          attFix.putIfAbsent(att.name, () => (v as TextEditingController).text);
                        } else if (att.type.toLowerCase() == "enum") {
                          attFix.putIfAbsent(att.name, () => v);
                        } else if (att.type.toLowerCase() == "date") {
                          attFix.putIfAbsent(att.name, () => (v as DateTime?).format_yyMMdd);
                        } else if (att.type.toLowerCase() == "boolean") {
                          attFix.putIfAbsent(att.name, () => v);
                        } else if (att.type.toLowerCase() == "number") {
                          attFix.putIfAbsent(att.name, () => (v as TextEditingController).text);
                        } else if (att.type.toLowerCase() == "float") {
                          attFix.putIfAbsent(att.name, () => (v as TextEditingController).text);
                        } else if (att.type.toLowerCase() == "multiselectlist") {
                          attFix.putIfAbsent(att.name, () => v);
                        }
                      });
                      await myProfileController.editProfile(profile, {"firstname": firstNameC.text, "middlename": middleNameC.text, "lastname": lastNameC.text}, attFix);
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
