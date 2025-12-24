import 'package:abds/core/classes/people_class.dart';
import 'package:abds/core/classes/user_class.dart';
import 'package:abds/core/utils_and_services/icomoon_layered_presets_from_css.dart';
import 'package:abds/screens/login/login_state.dart';
import 'package:abds/screens/users/users_controller.dart';
import 'package:abds/screens/users/users_state.dart';
import 'package:abds/widgets/DotButton.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:abds/widgets/MyFieldPicker.dart';
import 'package:abds/widgets/MySwitchButton.dart';
import 'package:abds/widgets/MyTextFieldNew.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../initialize.dart';

class UserDetailsDialog extends ConsumerStatefulWidget {
  final People user;

  const UserDetailsDialog({super.key, required this.user});

  @override
  ConsumerState<UserDetailsDialog> createState() => _UserDetailsDialogState();
}

class _UserDetailsDialogState extends ConsumerState<UserDetailsDialog> {
  UsersController myUsersControllers = getIt<UsersController>();
  late People tmp = widget.user;
  late TextEditingController fNameC = TextEditingController.fromValue(TextEditingValue(text: widget.user.firstname ?? ''));
  late TextEditingController lNameC = TextEditingController.fromValue(TextEditingValue(text: widget.user.lastname ?? ''));
  late TextEditingController passwordC = TextEditingController.fromValue(TextEditingValue(text: '********'));
  late TextEditingController employeeIdC = TextEditingController.fromValue(TextEditingValue(text: widget.user.employeeId ?? ''));
  late TextEditingController whatsappNumberC = TextEditingController.fromValue(TextEditingValue(text: widget.user.whatsappNumber ?? ''));
  late TextEditingController emailC = TextEditingController.fromValue(TextEditingValue(text: widget.user.email ?? ''));

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
    final u = ref.watch(peopleListProvider).firstWhere((a) => a.uId == widget.user.uId);
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        width: 430,
        height: 430,
        decoration: BoxDecoration(
          color: Color(0xffEAECF2),
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(child: Text("User Details")),
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 12,
                  children: [
                    Row(
                      spacing: 12,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              IcomoonLayeredCss.user_square(colors: [Colors.black12, Color(0xff858A99), Color(0xff858A99)], size: 44),
                              const SizedBox(width: 8),
                              Expanded(
                                child: MyTextFieldNew(
                                  label: "Firstname",
                                  controller: fNameC,
                                  bodyBgColor: Colors.white54,
                                  backgroundColor: Colors.white54,
                                  labelInRow: false,
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: MyTextFieldNew(
                                  label: "Lastname",
                                  controller: lNameC,
                                  bodyBgColor: Colors.white54,
                                  backgroundColor: Colors.white54,
                                  labelInRow: false,
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 12,
                      children: [
                        Expanded(
                          child: MyTextFieldNew(
                            label: "Password",
                            controller: passwordC,
                            bodyBgColor: Colors.white54,
                            backgroundColor: Colors.white54,
                            labelInRow: false,
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: FieldData(
                                  label: 'User Type',
                                  data: widget.user.userType ?? '',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 12,
                      children: [
                        Expanded(
                          child: MyFieldPicker(
                            label: "Station",
                            items:["1","2","#"],
                            bodyBgColor: Colors.white54,
                            backgroundColor: Colors.white54,
                            labelInRow: false,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: MyTextFieldNew(
                                  label: "Employee ID",
                                  controller: employeeIdC,
                                  bodyBgColor: Colors.white54,
                                  backgroundColor: Colors.white54,
                                  labelInRow: false,
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 12,
                      children: [
                        Expanded(
                          child: MyTextFieldNew(
                            label: "Whatsapp Number",
                            controller: whatsappNumberC,
                            bodyBgColor: Colors.white54,
                            backgroundColor: Colors.white54,
                            labelInRow: false,
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: MyTextFieldNew(
                                  label: "Email",
                                  controller: emailC,
                                  bodyBgColor: Colors.white54,
                                  backgroundColor: Colors.white54,
                                  labelInRow: false,
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        // CupertinoSwitch(value: user.enable, onChanged: (a){}),
                        Switch(
                          value: tmp.enable,
                          inactiveThumbColor: Colors.grey,
                          onChanged: (a) async {
                            tmp.enable = a;
                            setState(() {});
                            // await getIt<UsersController>().enableDisableUser(user: widget.user, enable: a);
                          },
                        ),
                        const SizedBox(width: 8),
                        Text("Active User"),
                      ],
                    ),
                  ],
                ),
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
                      label: "Edit User",
                      radius: 12,
                      onPressed: () async {
                        await myUsersControllers.updateUser(
                          user: tmp,
                          enable: tmp.enable,
                          permission: tmp.userPermission,
                          attributes: tmp.userAttribute,
                          firstName: fNameC.text,
                          lastName: lNameC.text,
                          password: passwordC.text,
                          email: emailC.text,
                        );
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
