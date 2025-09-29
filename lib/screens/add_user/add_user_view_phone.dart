import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import '../../core/classes/basic_class.dart';
import '../../core/classes/people_class.dart';
import '../../core/classes/user_permission_class.dart';
import '../../core/constants/ui.dart';
import '../../widgets/DotButton.dart';
import '../../widgets/MyButton.dart';
import '../../widgets/MyTextField.dart';
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

    UserPermission addingP = UserPermission({});
    aup = addingP;
    super.initState();
  }

  addUser() async {
    await myAddUserController.addUser(username: usernameC.text, email: emailC.text, password: passwordC.text, firstname: firstNameC.text, lastname: lastNameC.text, permissions: aup

    );
  }

  @override
  Widget build(BuildContext context) {
    final permissions = myAddUserController.ref.read(userProvider)!.permission;
    bool isValid = emailC.text.isEmail || (usernameC.text.length>5 && passwordC.text == passwordConfirmC.text && passwordC.text.isNotEmpty);

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
                                              aup = aup.grantFlag(area, a.flag);
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
                                      ...perList.map((ap) {
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
            Container(
              padding: EdgeInsets.only(left: 24,right: 24,bottom: 24,top: 12),
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
                      onPressed:!isValid?null: () async {
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
                      Text("AddUser", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
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
