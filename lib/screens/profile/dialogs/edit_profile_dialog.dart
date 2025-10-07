import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/classes/basic_class.dart';
import '../../../core/classes/people_class.dart';
import '../../../core/interfaces/success_int.dart';
import '../../../core/utils_and_services/handlers/success_handler.dart';
import '../../../core/utils_and_services/timatic/src/models/auth_response.dart';
import '../../../initialize.dart';
import '../../../widgets/DotButton.dart';
import '../../../widgets/MyButton.dart';

import '../../../core/constants/ui.dart';
import '../../../core/navigation/navigation_service.dart';
import '../../../widgets/MySwitchButton.dart';
import '../../../widgets/MyTextField.dart';
import '../../../widgets/SelectionChip.dart';
import '../../login/login_state.dart';
import '../profile_controller.dart';

class EditProfileDialog extends StatefulWidget {
  final Profile profile;

  const EditProfileDialog({super.key, required this.profile});

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  final ProfileController myProfilesController = getIt<ProfileController>();

  TextEditingController firstNameC = TextEditingController();
  TextEditingController lastNameC = TextEditingController();
  TextEditingController middleNameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController usernameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController passwordConfirmC = TextEditingController();
  FocusNode firstNameFN = FocusNode();
  FocusNode lastNameFN = FocusNode();
  FocusNode middleNameFN = FocusNode();
  FocusNode emailFN = FocusNode();
  FocusNode phoneFN = FocusNode();
  FocusNode usernameFN = FocusNode();
  FocusNode passwordFN = FocusNode();
  FocusNode passwordConfirmFN = FocusNode();
  bool loading = false;

  late Profile tmp ;
  // List<ProfilePermission> includedPermissions = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      tmp = Profile.fromJson(widget.profile.toJson());
      firstNameC.text = tmp.firstname??'';
      lastNameC.text = tmp.lastname??'';
      middleNameC.text = tmp.middlename??'';


      firstNameC.addListener(()=>setState((){}));
      lastNameC.addListener(()=>setState((){}));
      middleNameC.addListener(()=>setState((){}));
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final permissions = myProfilesController.ref.read(userProvider)!.permission;
    // log(permissions.airlines.map((a)=>a.airline.code).join("--"));
    // log(tmp.airlines.map((a)=>a.airline.code).join("--"));
    // final current = widget.user.permission;
    // log("--" * 40);
    // log(jsonEncode(current.toJson()));
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
      insetPadding: context.getDialogPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const SizedBox(width: 18),
              const Text("Edit Profile", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const Divider(height: 1),
          Container(
            color: MyColors.scaffoldBg,
            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12),
            child: Column(
              spacing: 12,
              children: [
                MyTextField(label: "Firstname",controller: firstNameC,focusNode: firstNameFN,labelInRow: true,),
                MyTextField(label: "Middle name",controller: middleNameC,focusNode: middleNameFN,labelInRow: true,),
                MyTextField(label: "Lastname",controller: lastNameC,focusNode: lastNameFN,labelInRow: true,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 12, bottom: 8),
            child: Row(
              children: [
                //TextButton(onPressed: () {}, child: const Text("Add")),
                const Spacer(),
                MyButton(onPressed: () => Navigator.of(context).pop(), label: "Cancel", color: MyColors.greyishBrown),
                const SizedBox(width: 8),
                MyButton(
                  onPressed: () async {
                    // final res = await myProfilesController.editProfile(widget.profile,{
                    //   "firstname": firstNameC.text,
                    //   "middlename": middleNameC.text,
                    //   "lastname": lastNameC.text,
                    // });
                    // if (res != null) {
                    //   Navigator.of(context).pop();
                    //   Future.delayed(Duration(milliseconds: 500), () {
                    //     SuccessHandler.handle(ServerSuccess(code: 1, msg: "Profile Updated Successfully"));
                    //   });
                    // }
                  },
                  label: "Save",
                  color: theme.primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
