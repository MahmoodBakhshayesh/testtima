import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/classes/basic_class.dart';
import '../../../core/classes/people_class.dart';
import '../../../core/classes/user_permission_class.dart';
import '../../../core/interfaces/success_int.dart';
import '../../../core/utils_and_services/handlers/success_handler.dart';
import '../../../initialize.dart';
import '../../../widgets/DotButton.dart';
import '../../../widgets/MyButton.dart';

import '../../../core/constants/ui.dart';
import '../../../core/navigation/navigation_service.dart';
import '../../../widgets/MySwitchButton.dart';
import '../../../widgets/MyTextField.dart';
import '../../../widgets/SelectionChip.dart';
import '../../login/login_state.dart';
import '../users_controller.dart';

class EditUserDialog extends StatefulWidget {
  final People user;

  const EditUserDialog({super.key, required this.user});

  @override
  State<EditUserDialog> createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<EditUserDialog> {
  final UsersController myUsersController = getIt<UsersController>();

  TextEditingController firstNameC = TextEditingController();
  TextEditingController lastNameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController usernameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController passwordConfirmC = TextEditingController();
  FocusNode firstNameFN = FocusNode();
  FocusNode lastNameFN = FocusNode();
  FocusNode emailFN = FocusNode();
  FocusNode phoneFN = FocusNode();
  FocusNode usernameFN = FocusNode();
  FocusNode passwordFN = FocusNode();
  FocusNode passwordConfirmFN = FocusNode();
  bool loading = false;

  late bool active = widget.user.enable;
  late UserPermission tmp = UserPermission.fromPermissionMap(widget.user.userPermission.toPermissionMap());
  // late Map<String,int> tmp = Map<String,int>.from(widget.user.permission);


  // List<UserPermission> includedPermissions = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final permissions = myUsersController.ref.read(userProvider)!.permission;

      // tmp = permissions.where((p) => widget.user.permission.map((pp) => pp.id).contains(p.id)).map((a) {
      //   final peoplePer = widget.user.permissions.firstWhereOrNull((pp) => pp.id == a.id);
      //   return UserPermission(
      //       id: a.id,
      //       name: a.name,
      //       permission: (peoplePer ??
      //               UserPermission(
      //                   id: a.id, name: a.name, permission: ActivePermissions.fromBitmask(BasicClass.constData.userPermissionAttributes, a.permission.toJson()), allPermissions: BasicClass.constData.userPermissionAttributes))
      //           .permission,
      //       allPermissions: BasicClass.constData.userPermissionAttributes);
      // }).toList();

      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final permissions = myUsersController.ref.read(userProvider)!.permission;
    // log(permissions.airlines.map((a)=>a.airline.code).join("--"));
    // log(tmp.airlines.map((a)=>a.airline.code).join("--"));
    // final current = widget.user.permission;
    // log("--" * 40);
    return Dialog(
      insetPadding: context.getDialogPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const SizedBox(width: 18),
              const Text("Edit User", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
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
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(child: Text(widget.user.username ?? widget.user.email ?? '')),
                  Expanded(
                    child: MySwitchButton(
                      height: 35,
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      value: active,
                      onChanged: (a) {
                        active = a;
                        setState(() {});
                      },
                      label: !active ? "Inactive" : "Active",
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(height: 24,),
                        Text("Permissions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Column(
                          children: BasicClass.constData.data.permission.areas.map((area,cat) {
                            // final perList = permissions.allPermissions.getPermissionsFor(cat);
                            // final perList = permissions.permission.getPermissionsFor(cat);
                            final perList = BasicClass.constData.data.permission[area];
                            if(perList.isEmpty ){
                              return MapEntry(area, SizedBox());
                            }
                            return MapEntry(area,Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text("${area.capitalizeFirst}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                      ),
                                      DotButton(
                                        icon: Icons.select_all,
                                        onPressed: () {
                                          for (var a in perList) {
                                            tmp = tmp.grantFlag(area, a.flag);
                                          }
                                          setState(() {});
                                        },
                                        color: Colors.green,
                                      ),
                                      const SizedBox(width: 8),
                                      DotButton(
                                        icon: Icons.deselect,
                                        onPressed: () {
                                          for (var a in perList) {
                                            tmp = tmp.revokeFlag(area, a.flag);
                                          }
                                          setState(() {});
                                        },
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                ),
                                Wrap(
                                  children: [
                                    ...perList.map((ap) {
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 4.0),
                                        child: SelectionChip(
                                          value: tmp.hasFlag(area, ap.flag),
                                          label: ap.value,
                                          onSelected: (bool value) {
                                            tmp = tmp.toggleFlag(area, ap.flag);
                                            setState(() {});
                                          },
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                                Divider(),
                              ],
                            ));
                          }).values.toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
                    final res = await myUsersController.updateUser(user: widget.user, enable: active, permission: tmp);
                    if (res != null) {
                      Navigator.of(context).pop();
                      Future.delayed(Duration(milliseconds: 300), () {
                        SuccessHandler.handle(ServerSuccess(code: 1, msg: "User Updated Successfully"));
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
