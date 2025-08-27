import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/screens/login/login_controller.dart';
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

class ChangePasswordDialog extends StatefulWidget {
  final Profile profile;

  const ChangePasswordDialog({super.key, required this.profile});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final ProfileController myProfilesController = getIt<ProfileController>();

  TextEditingController passwordC = TextEditingController();
  TextEditingController newPassC = TextEditingController();

  FocusNode passwordFN = FocusNode();
  FocusNode newPassFN = FocusNode();
  bool loading = false;

  late Profile tmp ;
  // List<ProfilePermission> includedPermissions = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      tmp = Profile.fromJson(widget.profile.toJson());
      passwordC.addListener(()=>setState((){}));
      newPassC.addListener(()=>setState((){}));
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
              const Text("Change Password", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
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
                MyTextField(label: "Old Password",controller: passwordC,focusNode: passwordFN,labelInRow: true,isPassword: true,),
                MyTextField(label: "New Password",controller: newPassC,focusNode: newPassFN,labelInRow: true,isPassword: true,),
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
                    final res = await myProfilesController.editProfile(widget.profile,{"oldPassword":passwordC.text,"newPassword":newPassC.text});
                    if (res != null) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      getIt<LoginController>().logout();
                      Future.delayed(Duration(milliseconds: 500), () {
                        SuccessHandler.handle(ServerSuccess(code: 1, msg: "Password Updated Successfully"));
                      });
                    }
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
