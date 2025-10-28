import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/screens/users/dialogs/change_ohers_password_dialog.dart';
import 'package:abds/widgets/MyDatePicker.dart';
import 'package:abds/widgets/MyExpansionTile.dart';
import 'package:abds/widgets/MyFieldPicker.dart';
import 'package:abds/widgets/MyTextFieldNew.dart';
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
import '../../../widgets/MyMultiFieldPicker.dart';
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
  late UserPermission aup = UserPermission.fromPermissionMap(widget.user.userPermission.toPermissionMap());

  Map<String, dynamic> attributes = {};

  // late Map<String,int> tmp = Map<String,int>.from(widget.user.permission);

  // List<UserPermission> includedPermissions = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final permissions = myUsersController.ref.read(userProvider)!.permission;
      BasicClass.constData.data.attribute.where((a) => a.onlyOwner).forEach((att) {
        if (att.type.toLowerCase() == "string") {
          attributes.putIfAbsent(att.name, () => TextEditingController(text: widget.user.userAttribute[att.name]));
        } else if (att.type.toLowerCase() == "enum") {
          attributes.putIfAbsent(att.name, () => widget.user.userAttribute[att.name]);
        } else if (att.type.toLowerCase() == "date") {
          attributes.putIfAbsent(att.name, () => DateTime.tryParse(widget.user.userAttribute[att.name]));
        } else if (att.type.toLowerCase() == "boolean") {
          attributes.putIfAbsent(att.name, () => (widget.user.userAttribute[att.name]) ?? false);
        } else if (att.type.toLowerCase() == "number") {
          attributes.putIfAbsent(att.name, () => TextEditingController(text: widget.user.userAttribute[att.name]?.toString()));
        } else if (att.type.toLowerCase() == "float") {
          attributes.putIfAbsent(att.name, () => TextEditingController(text: widget.user.userAttribute[att.name]?.toString()));
        } else if (att.type.toLowerCase() == "multiselectlist") {
          attributes.putIfAbsent(att.name, () => (widget.user.userAttribute[att.name] ?? []));
        }
      });
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
    final headerBg = MyColors.green2.withOpacity(0.26);
    final bodyBg = MyColors.green2.withOpacity(0.12);
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
                  spacing: 12,
                  children: [
                    MyTextFieldNew(
                        headerBgColor: headerBg,
                        bodyBgColor: bodyBg,
                        label: "Email", controller: emailC, keyboardType: TextInputType.emailAddress),
                    MyExpansionTile(
                      showFooter: false,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
                      collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
                      childrenPadding: EdgeInsets.symmetric(horizontal: 12),
                      tilePadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      backgroundColor: Colors.green.withOpacity(0.08),
                      collapsedBackgroundColor: Colors.green.withOpacity(0.08),
                      title: Text("Attributes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      children: BasicClass.constData.data.attribute.where((a) => a.onlyOwner).map((att) {

                        if (att.type == "string") {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: MyTextFieldNew(headerBgColor: headerBg, bodyBgColor: bodyBg, label: att.title, placeholder: att.title, controller: attributes[att.name]),
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
                        } else if (att.type == "multiselectlist") {
                          final overrideList = BasicClass.constData.data.toJson()["${att.listItemName}"];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: MyMultiFieldPicker(
                              required: att.mandatory,
                              headerBgColor: headerBg,
                              bodyBgColor: bodyBg,
                              values: attributes[att.name] ?? [],
                              onChange: (a) {
                                log(a.runtimeType.toString());
                                attributes[att.name] = a;
                                setState(() {});
                              },
                              label: att.title,
                              placeholder: att.title,
                              items: overrideList,
                            ),
                          );
                        }
                        return Container(child: Row(children: [Text("${att.title}")]));
                      }).toList(),
                    ),
                    MyExpansionTile(
                      showFooter: false,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
                      collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
                      childrenPadding: EdgeInsets.symmetric(horizontal: 12),
                      backgroundColor: Colors.blueAccent.withOpacity(0.08),
                      tilePadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),

                      collapsedBackgroundColor: Colors.blueAccent.withOpacity(0.08),
                      title: Text("Permissions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      children: BasicClass.constData.data.permission.areas
                          .map((area, cat) {
                            final perList = BasicClass.constData.data.permission[area];
                            if (permissions.maskOf(area) == 0) {
                              return MapEntry(area, SizedBox());
                            }
                            if (perList.isEmpty) {
                              return MapEntry(area, SizedBox());
                            }
                            return MapEntry(
                              area,
                              Container(
                                margin: EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.48),
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.all(12),
                                child: Column(
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
                                                if (permissions.hasFlag(area, a.flag)) {
                                                  aup = aup.grantFlag(area, a.flag);
                                                }
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
                                                aup = aup.revokeFlag(area, a.flag);
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
                                        ...perList.where((a) => permissions.hasFlag(area, a.flag)).map((ap) {
                                          return Padding(
                                            padding: const EdgeInsets.only(right: 4.0),
                                            child: SelectionChip(
                                              value: aup.hasFlag(area, ap.flag),
                                              label: ap.value,
                                              onSelected: (bool value) {
                                                aup = aup.toggleFlag(area, ap.flag);
                                                setState(() {});
                                              },
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                    Divider(),
                                  ],
                                ),
                              ),
                            );
                          })
                          .values
                          .toList(),
                    ),
                    Row(
                      children: [
                        Spacer(),
                        MyButton(
                          label: "Change Password",
                          icon: Icons.lock,
                          reverse: true,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (c) {
                                return ChangeOthersPasswordDialog(user: widget.user);
                              },
                            );
                          },
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
                    final attFix = <String, dynamic>{};
                    attributes.forEach((k, v) {
                      final att = BasicClass.constData.data.attribute.firstWhere((a) => a.name == k);
                      if (att.type == "string") {
                        attFix.putIfAbsent(att.name, () => (v as TextEditingController).text);
                      } else if (att.type == "enum") {
                        attFix.putIfAbsent(att.name, () => v);
                      } else if (att.type == "date") {
                        attFix.putIfAbsent(att.name, () => (v as DateTime?).format_yyMMdd);
                      } else if (att.type == "boolean") {
                        attFix.putIfAbsent(att.name, () => v);
                      } else if (att.type == "number") {
                        attFix.putIfAbsent(att.name, () => (v as TextEditingController).text);
                      } else if (att.type == "float") {
                        attFix.putIfAbsent(att.name, () => (v as TextEditingController).text);
                      } else if (att.type == "multiselectlist") {
                        attFix.putIfAbsent(att.name, () => v);
                      }
                    });
                    final res = await myUsersController.updateUser(user: widget.user, enable: active, permission: aup, attributes: attFix,email: emailC.text);
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
