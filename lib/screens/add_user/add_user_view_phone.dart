import 'dart:convert';
import 'dart:developer';

import 'package:abds/core/interfaces/failures_int.dart';
import 'package:abds/core/utils_and_services/handlers/failure_handler.dart';
import 'package:abds/widgets/MyMultiFieldPicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import '../../core/classes/basic_class.dart';
import '../../core/classes/people_class.dart';
import '../../core/classes/user_permission_class.dart';
import '../../core/constants/ui.dart';
import '../../widgets/DotButton.dart';
import '../../widgets/MyButton.dart';
import '../../widgets/MyDatePicker.dart';
import '../../widgets/MyExpansionTile.dart';
import '../../widgets/MyFieldPicker.dart';
import '../../widgets/MyTextField.dart';
import '../../widgets/MyTextFieldNew.dart';
import '../../widgets/SelectionChip.dart';
import '../login/login_state.dart';
import 'add_user_controller.dart';
import 'add_user_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';

class AddUserViewPhone extends StatefulWidget {
  static AddUserController myAddUserController = getIt<AddUserController>();

  const AddUserViewPhone({super.key});

  @override
  State<AddUserViewPhone> createState() => _AddUserViewPhoneState();
}

class _AddUserViewPhoneState extends State<AddUserViewPhone> {
  static AddUserController myAddUserController = getIt<AddUserController>();

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

  // late List<UserPermission> addingUserPermission = [...myAddUserController.ref.read(userProvider)!.permissions].map((a) => UserPermission.fromJson(a.toJson())).toList();
  // late List<UserPermission> addingUserPermission = [];

  late UserPermission aup;
  Map<String, dynamic> attributes = {};

  // List<AirportUserPermission> includedAirports = [];
  // List<HandlingUserPermission> includedHandlings = [];

  @override
  void initState() {
    firstNameC.addListener(() => setState(() {}));
    lastNameC.addListener(() => setState(() {}));
    emailC.addListener(() => setState(() {}));
    phoneC.addListener(() => setState(() {}));
    usernameC.addListener(() => setState(() {}));
    passwordC.addListener(() => setState(() {}));
    passwordConfirmC.addListener(() => setState(() {}));


    // UserPermission addingP = UserPermission({});
    UserPermission addingP = myAddUserController.ref.read(userProvider)!.permission;
    BasicClass.constData.data.attribute.where((a) => a.onlyOwner).forEach((att) {
      if (att.type.toLowerCase() == "string") {
        attributes.putIfAbsent(att.name, () => TextEditingController(text: ''));
      } else if (att.type.toLowerCase() == "enum") {
        var value;
        if(att.getOverrideList.length==1){
          value = att.getOverrideList.first;
        }
        attributes.putIfAbsent(att.name, () => value);
      } else if (att.type.toLowerCase() == "date") {
        attributes.putIfAbsent(att.name, () => null);
      } else if (att.type.toLowerCase() == "boolean") {
        attributes.putIfAbsent(att.name, () => false);
      } else if (att.type.toLowerCase() == "number") {
        attributes.putIfAbsent(att.name, () => TextEditingController());
      } else if (att.type.toLowerCase() == "float") {
        attributes.putIfAbsent(att.name, () => TextEditingController());
      } else if (att.type.toLowerCase() == "multiselectlist") {
        attributes.putIfAbsent(att.name, () => []);
      } else {
        log(att.type);
      }
    });
    aup = addingP;
    super.initState();
  }

  addUser() async {
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
      }else if (att.type.toLowerCase() == "multiselectlist") {
        attFix.putIfAbsent(att.name, () => v);
      }
    });
    List<String> requiredButNulls = attFix.keys.where((a) => BasicClass.constData.data.attribute.firstWhere((at) => at.name == a).mandatory && (attFix[a] == null || attFix[a].toString().isEmpty)).toList();
    if (requiredButNulls.isEmpty) {
      log("requiredButNulls is empty");
      await myAddUserController.addUser(username: usernameC.text, email: emailC.text, password: passwordC.text, firstname: firstNameC.text, lastname: lastNameC.text, permissions: aup, attributes: attFix);
    }else{
      FailureHandler.handle(ValidationFailure(code: -1, msg: "Required Attributes : ${requiredButNulls.join(", ")}", traceMsg: "Required Attributes : ${requiredButNulls.join(", ")}"));
    }
  }

  @override
  Widget build(BuildContext context) {
    final permissions = myAddUserController.ref.read(userProvider)!.permission;
    bool isValid = emailC.text.isEmail || (usernameC.text.length > 5 && passwordC.text == passwordConfirmC.text && passwordC.text.isNotEmpty);

    return Scaffold(
      appBar: AddUserAppBar(),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(18),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Row(
                        spacing: 12,
                        children: [
                          Expanded(
                            child: MyTextField(label: "First Name", controller: firstNameC, focusNode: firstNameFN),
                          ),
                          Expanded(
                            child: MyTextField(label: "Last Name", controller: lastNameC, focusNode: lastNameFN),
                          ),
                        ],
                      ),
                      MyTextField(
                        label: "Email",
                        controller: emailC,
                        focusNode: emailFN,
                        keyboardType: TextInputType.emailAddress,
                        validator: (a) {
                          if (!a.isEmail && a.isNotEmpty) {
                            return "Invalid Email";
                          }
                        },
                      ),
                      MyTextField(
                        label: "Username",
                        required: emailC.text.isEmpty,
                        controller: usernameC,
                        focusNode: usernameFN,
                        validator: (a) {
                          if (a.length < 6 && a.isNotEmpty) {
                            return "Username must have at least 6 characters";
                          }
                        },
                      ),
                      MyTextField(
                        isPassword: true,
                        required: emailC.text.isEmpty,
                        label: "Password",
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordC,
                        focusNode: passwordFN,
                        validator: (a) {
                          return null;
                          if (a.isNotEmpty && passwordConfirmC.text.isNotEmpty && a != passwordConfirmC.text) {
                            return "Passwords does not match";
                          }
                        },
                      ),
                      MyTextField(
                        isPassword: true,
                        required: emailC.text.isEmpty,
                        label: "Password Confirm",
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordConfirmC,
                        focusNode: passwordConfirmFN,
                        validator: (a) {
                          if (a.isEmpty && passwordC.text.isNotEmpty) {
                            return "Passwords confirm is required";
                          }
                          if (a.isNotEmpty && passwordC.text.isNotEmpty && a != passwordC.text) {
                            return "Passwords does not match";
                          }
                        },
                      ),
                      const SizedBox(height: 0),
                      MyExpansionTile(
                        showFooter: false,
                        showTrailingIcon: true,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
                        collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
                        childrenPadding: EdgeInsets.symmetric(horizontal: 12),
                        backgroundColor: Colors.green.withOpacity(0.08),
                        tilePadding: EdgeInsets.all(8),
                        collapsedBackgroundColor: Colors.green.withOpacity(0.08),
                        title: Text("Attributes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        children: BasicClass.constData.data.attribute.where((a) => a.onlyOwner).map((att) {
                          final headerBg = MyColors.green2.withOpacity(0.26);
                          final bodyBg = MyColors.green2.withOpacity(0.12);
                          if (att.type == "string") {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: MyTextFieldNew(
                                required: att.mandatory,
                                rowLabelRatio: [4,5],
                                headerBgColor: headerBg,
                                bodyBgColor: bodyBg,
                                label: att.title,
                                placeholder: att.title,
                                controller: attributes[att.name],
                              ),
                            );
                          } else if (att.type == "enum") {
                            // log(att.listItemName.toString());
                            // log(BasicClass.constData.data.toJson()["${att.listItemName}"].toString());
                            final overrideList = att.getOverrideList;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: MyFieldPicker<dynamic>(
                                items:(overrideList is List)?overrideList: att.defaultList,
                                // items: att.defaultList,
                                required: att.mandatory,
                                rowLabelRatio: [4,5],

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
                              child: MyTextFieldNew(
                                required: att.mandatory,
                                rowLabelRatio: [4,5],

                                headerBgColor: headerBg,
                                bodyBgColor: bodyBg,
                                label: att.title,
                                placeholder: att.title,
                                controller: attributes[att.name],
                              ),
                            );
                          } else if (att.type == "number") {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: MyTextFieldNew(
                                required: att.mandatory,
                                rowLabelRatio: [4,5],

                                headerBgColor: headerBg,
                                bodyBgColor: bodyBg,
                                keyboardType: TextInputType.numberWithOptions(signed: true),
                                inputFormatters: [MyInputFormatter.justNumber],
                                label: att.title,
                                placeholder: att.title,
                                controller: attributes[att.name],
                              ),
                            );
                          } else if (att.type == "float") {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: MyTextFieldNew(
                                required: att.mandatory,
                                rowLabelRatio: [4,5],

                                headerBgColor: headerBg,
                                bodyBgColor: bodyBg,
                                keyboardType: TextInputType.numberWithOptions(signed: true),
                                inputFormatters: [MyInputFormatter.justNumber],
                                label: att.title,
                                placeholder: att.title,
                                controller: attributes[att.name],
                              ),
                            );
                          } else if (att.type == "date") {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: MyDatePicker(
                                required: att.mandatory,
                                rowLabelRatio: [4,5],

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
                          }else if (att.type == "multiselectlist") {
                            final overrideList = att.getOverrideList;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: MyMultiFieldPicker(
                                required: att.mandatory,
                                headerBgColor: headerBg,
                                bodyBgColor: bodyBg,
                                rowLabelRatio: [4,5],

                                values:  attributes[att.name],
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
                      const SizedBox(height: 12),
                      MyExpansionTile(
                        tilePadding: EdgeInsets.all(8),
                        showFooter: false,
                        showTrailingIcon: true,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
                        collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
                        childrenPadding: EdgeInsets.symmetric(horizontal: 12),
                        backgroundColor: Colors.blueAccent.withOpacity(0.08),
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
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 12),
              color: MyColors.greyBG,
              child: Row(
                children: [
                  Expanded(
                    child: MyButton(
                      height: 50,
                      label: "Add User",
                      icon: Icons.perm_identity,
                      borderSide: BorderSide(color: context.mainColor),
                      iconInRight: true,
                      onPressed: !isValid
                          ? null
                          : () async {
                              await addUser();
                            },
                      radius: 12,
                    ),
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

class AddUserAppBar extends StatelessWidget implements PreferredSizeWidget {
  static AddUserController myAddUserController = getIt<AddUserController>();

  const AddUserAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(108);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: Colors.white,
      alignment: Alignment.center,
      child: const SafeArea(
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
                      Text("Add User", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
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
