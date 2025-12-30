import 'dart:io';

import 'package:abds/core/classes/basic_class.dart';
import 'package:abds/core/classes/people_class.dart';
import 'package:abds/core/classes/user_class.dart';
import 'package:abds/core/enums/user_type_enum.dart';
import 'package:abds/core/utils_and_services/icomoon_layered_presets_from_css.dart';
import 'package:abds/screens/add_user/add_user_controller.dart';
import 'package:abds/screens/login/login_state.dart';
import 'package:abds/screens/menu_item_add_edit/menu_item_add_edit_view_desktop.dart';
import 'package:abds/screens/users/users_controller.dart';
import 'package:abds/screens/users/users_state.dart';
import 'package:abds/widgets/DotButton.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:abds/widgets/MyFieldPicker.dart';
import 'package:abds/widgets/MySwitchButton.dart';
import 'package:abds/widgets/MyTextFieldNew.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../initialize.dart';

class AddUserDialog extends ConsumerStatefulWidget {
  const AddUserDialog({super.key});

  @override
  ConsumerState<AddUserDialog> createState() => _UserDetailsDialogState();
}

class _UserDetailsDialogState extends ConsumerState<AddUserDialog> {
  UsersController myUsersControllers = getIt<UsersController>();
  late TextEditingController fNameC = TextEditingController();
  late TextEditingController lNameC = TextEditingController();
  late TextEditingController passwordC = TextEditingController();
  late TextEditingController usernameC = TextEditingController();
  late TextEditingController employeeIdC = TextEditingController();
  late TextEditingController whatsappNumberC = TextEditingController();
  late TextEditingController emailC = TextEditingController();
  String? station;
  UserType userType = UserType.share;
  File? profile;
  final headerBg = Colors.white;
  final bodyBg = Colors.white54;

  @override
  void initState() {
    // fNameC.addListener(() {
    //   tmp.firstname = fNameC.text;
    //   setState(() {});
    // });
    // lNameC.addListener(() {
    //   tmp.lastname = lNameC.text;
    //   setState(() {});
    // });
    // passwordC.addListener(() {
    //   // tmp.lastname = passwordC.text;
    //   setState(() {});
    // });
    // employeeIdC.addListener(() {
    //   tmp.userAttribute["employeeId"] = employeeIdC.text;
    //   setState(() {});
    // });
    // whatsappNumberC.addListener(() {
    //   tmp.userAttribute["whatsappNumber"] = whatsappNumberC.text;
    //   setState(() {});
    // });
    // emailC.addListener(() {
    //   tmp.email = emailC.text;
    //   setState(() {});
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        width: 500,
        decoration: BoxDecoration(
          color: Color(0xffEAECF2),
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(child: Text("Add User")),
                  DotButton(
                    icon: Icons.close,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.black26,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                spacing: 12,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: MyFieldPicker<UserType>(
                          label: "User Type",
                          items: UserType.values,
                          headerBgColor: headerBg,
                          bodyBgColor: bodyBg,
                          value: userType,
                          onChange: (a) {
                            if (a == null) return;
                            userType = a;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Builder(
                    builder: (BuildContext context) {
                      switch (userType) {
                        case UserType.supervisor:
                          return Column(
                            spacing: 12,
                            children: [
                              buildAvatar(),
                              buildFirstName(),
                              buildLastName(),
                              buildPassword(),
                              buildEmployeeId(),
                              buildEmail(),
                              buildWhatsapp(),
                              buildStation(),
                            ],
                          );
                        case UserType.agent:
                          return Column(
                            spacing: 12,
                            children: [
                              buildAvatar(),
                              buildFirstName(),
                              buildLastName(),
                              buildEmployeeId(),
                              buildStation(),
                            ],
                          );
                        case UserType.share:
                          return Column(
                            spacing: 12,
                            children: [
                              buildUsername(),
                              buildPassword(),
                              buildStation(),
                            ],
                          );
                      }
                    },
                  ),
                  //
                  // Column(
                  //   children: [],
                  // ),
                  // Row(
                  //   spacing: 12,
                  //   children: [
                  //     Expanded(
                  //       child: Row(
                  //         children: [
                  //           IcomoonLayeredCss.user_square(colors: [Colors.black12, Color(0xff858A99), Color(0xff858A99)], size: 44),
                  //           const SizedBox(width: 8),
                  //           Expanded(
                  //             child: MyTextFieldNew(
                  //               label: "Firstname",
                  //               controller: fNameC,
                  //               bodyBgColor: Colors.white54,
                  //               backgroundColor: Colors.white54,
                  //               labelInRow: false,
                  //               borderSide: BorderSide(color: Colors.white),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Row(
                  //         children: [
                  //           Expanded(
                  //             child: MyTextFieldNew(
                  //               label: "Lastname",
                  //               controller: lNameC,
                  //               bodyBgColor: Colors.white54,
                  //               backgroundColor: Colors.white54,
                  //               labelInRow: false,
                  //               borderSide: BorderSide(color: Colors.white),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   spacing: 12,
                  //   children: [
                  //     Expanded(
                  //       child: MyTextFieldNew(
                  //         label: "Password",
                  //         controller: passwordC,
                  //         bodyBgColor: Colors.white54,
                  //         backgroundColor: Colors.white54,
                  //         labelInRow: false,
                  //         borderSide: BorderSide(color: Colors.white),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Row(
                  //         children: [
                  //           Expanded(
                  //             child: MyFieldPicker<String>(
                  //               labelInRow: false,
                  //               label: 'User Type',
                  //               items: [],
                  //               bodyBgColor: Colors.white54,
                  //               backgroundColor: Colors.white54,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   spacing: 12,
                  //   children: [
                  //     Expanded(
                  //       child: MyFieldPicker(
                  //         label: "Station",
                  //         items: ["1", "2", "#"],
                  //         bodyBgColor: Colors.white54,
                  //         backgroundColor: Colors.white54,
                  //         labelInRow: false,
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Row(
                  //         children: [
                  //           Expanded(
                  //             child: MyTextFieldNew(
                  //               label: "Employee ID",
                  //               controller: employeeIdC,
                  //               bodyBgColor: Colors.white54,
                  //               backgroundColor: Colors.white54,
                  //               labelInRow: false,
                  //               borderSide: BorderSide(color: Colors.white),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   spacing: 12,
                  //   children: [
                  //     Expanded(
                  //       child: MyTextFieldNew(
                  //         label: "Whatsapp Number",
                  //         controller: whatsappNumberC,
                  //         bodyBgColor: Colors.white54,
                  //         backgroundColor: Colors.white54,
                  //         labelInRow: false,
                  //         borderSide: BorderSide(color: Colors.white),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Row(
                  //         children: [
                  //           Expanded(
                  //             child: MyTextFieldNew(
                  //               label: "Email",
                  //               controller: emailC,
                  //               bodyBgColor: Colors.white54,
                  //               backgroundColor: Colors.white54,
                  //               labelInRow: false,
                  //               borderSide: BorderSide(color: Colors.white),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
              ),
              child: Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: MyButton(
                      label: "Close",
                      radius: 12,
                      borderSide: BorderSide(color: Colors.grey),
                      color: Colors.transparent,
                      textColor: Colors.black,
                      icon: Icons.close,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                    child: MyButton(
                      label: "Add User",
                      radius: 12,
                      onPressed: () async {
                        final addUserController = getIt<AddUserController>();
                        // await addUserController.addUser(
                        //   user: tmp,
                        //   enable: tmp.enable,
                        //   permission: tmp.userPermission,
                        //   attributes: tmp.userAttribute,
                        //   firstName: fNameC.text,
                        //   lastName: lNameC.text,
                        //   password: passwordC.text,
                        //   email: emailC.text,
                        // );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IcomoonLayeredCss.edit(colors: [Colors.white.withOpacity(0.34), Colors.white, Colors.white]),
                          const SizedBox(width: 8),
                          Text(
                            "Edit User",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
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

  buildAvatar() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(10),
          child: Container(width: 75, height: 75, color: Colors.grey, child: profile == null ? Icon(Icons.person, size: 35) : Image.file(profile!)),
        ),
        const SizedBox(width: 12),
        MyButton(
          label: "Add Profile Image",
          icon: Icons.add,
          onPressed: () async {
            final photo = await FilePicker.platform.pickFiles(type: FileType.image);
            if (photo?.files.first.path != null) {
              profile = File(photo!.files.first.path!);
              setState(() {});
            }
          },

          reverse: true,
        ),
      ],
    );
  }

  buildFirstName() {
    return MyTextFieldNew(
      headerBgColor: headerBg,
      bodyBgColor: bodyBg,
      placeholder: "First Name",
      label: "First Name",
      controller: fNameC,
    );
  }

  buildLastName() {
    return MyTextFieldNew(
      headerBgColor: headerBg,
      bodyBgColor: bodyBg,
      placeholder: "Last Name",
      label: "Last Name",
      controller: lNameC,
    );
  }

  buildEmployeeId() {
    return MyTextFieldNew(
      headerBgColor: headerBg,
      bodyBgColor: bodyBg,
      placeholder: "ID",
      label: "Employee ID",
      controller: employeeIdC,
    );
  }

  buildUsername() {
    return MyTextFieldNew(
      headerBgColor: headerBg,
      bodyBgColor: bodyBg,
      placeholder: "Username",
      label: "Username",
      controller: usernameC,
    );
  }

  buildPassword() {
    return MyTextFieldNew(
      headerBgColor: headerBg,
      bodyBgColor: bodyBg,
      placeholder: "Password",
      label: "Password",
      controller: passwordC,
    );
  }

  buildEmail() {
    return MyTextFieldNew(
      headerBgColor: headerBg,
      bodyBgColor: bodyBg,
      placeholder: "Email",
      label: "Email",
      controller: emailC,
    );
  }

  buildWhatsapp() {
    return MyTextFieldNew(
      headerBgColor: headerBg,
      bodyBgColor: bodyBg,
      placeholder: "Number",
      label: "Whatsapp Number",
      controller: whatsappNumberC,
    );
  }

  buildStation() {
    return MyFieldPicker<String>(
      label: "Station",
      headerBgColor: headerBg,
      bodyBgColor: bodyBg,
      items: List<String>.from(ref.watch(userProvider)!.setting!.more["defaultAirportList"]),
      value: station,
      onChange: (a) {
        station = a;
        setState(() {});
      },
    );
  }
}

class FieldData extends StatelessWidget {
  final String label;
  final String data;

  const FieldData({super.key, required this.label, required this.data});

  @override
  Widget build(BuildContext context) {
    return MyTextFieldNew(
      label: label,
      bodyBgColor: Colors.white54,
      backgroundColor: Colors.white54,
      labelInRow: false,
      borderSide: BorderSide(color: Colors.white),
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.38),
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w200),
          ),
          Text(data),
        ],
      ),
    );
  }
}
