import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/classes/server_class.dart';
import '../../../core/classes/user_class.dart';
import '../../../core/constants/ui.dart';
import '../../../core/interfaces/success_int.dart';
import '../../../core/utils_and_services/handlers/success_handler.dart';
import '../../../initialize.dart';
import '../../../widgets/MyButton.dart';
import '../../../widgets/MyTextField.dart';
import '../login_controller.dart';
import '../login_state.dart';

class SetFirstPasswordDialog extends StatefulWidget {
  final LoginData user;
  final String oldPassword;

  const SetFirstPasswordDialog({super.key, required this.user, required this.oldPassword});

  @override
  State<SetFirstPasswordDialog> createState() => _SetFirstPasswordDialogState();
}

class _SetFirstPasswordDialogState extends State<SetFirstPasswordDialog> {
  TextEditingController passwordC = TextEditingController();
  TextEditingController passwordConfirmC = TextEditingController();

  FocusNode passwordConfirmFN = FocusNode();
  FocusNode passwordFN = FocusNode();

  @override
  void initState() {
    passwordC.addListener(() => setState(() {}));
    passwordConfirmC.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isPassValid = passwordC.text.isNotEmpty && passwordC.text == passwordConfirmC.text;
    return Dialog(
      insetPadding: context.getDialogPadding,
      child: Container(
        constraints: BoxConstraints(maxHeight: height * 0.75),
        decoration: BoxDecoration(color: MyColors.greyBG, borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Text(
                "Set Password",
                style: TextStyles.styleBold16Black,
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  MyTextField(
                    isPassword: true,
                    required: true,
                    label: "Password",
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordC,
                    focusNode: passwordFN,
                    validator: (a) {
                      return null;
                      // if (a.isNotEmpty && passwordConfirmC.text.isNotEmpty && a != passwordConfirmC.text) {
                      //   return "Passwords does not match";
                      // }
                    },
                  ),
                  MyTextField(
                    isPassword: true,
                    required: true,
                    label: "Password Confirm",
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordConfirmC,
                    focusNode: passwordConfirmFN,
                    validator: (a) {
                      if (a.isNotEmpty && passwordC.text.isNotEmpty && a != passwordC.text) {
                        return "Passwords does not match";
                      }
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(right: 12, top: 12, bottom: 8),
              child: Row(
                children: [
                  const Spacer(),
                  MyButton(
                    flat: true,
                    label: "Cancel",
                    color: Colors.grey,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(width: 12),
                  MyButton(
                    label: "Set",
                    onPressed: !isPassValid
                        ? null
                        : () async {
                            final res = await getIt<LoginController>().setFirstPassword(oldPass: widget.oldPassword, newPass: passwordC.text);
                            if (res) {
                              Navigator.of(context).pop();
                              Future.delayed(Duration(milliseconds: 300), () {
                                SuccessHandler.handle(ServerSuccess(code: 1, msg: "Password set successfully!"));
                              });
                            }
                          },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
