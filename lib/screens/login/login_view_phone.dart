import 'package:abds/core/extenstions/context_exp.dart';

import '../../core/constants/assest.dart';
import '../../core/constants/ui.dart';
import '../../initialize.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/MyButton.dart';
import '../../widgets/MyTextField.dart';
import 'login_controller.dart';
import 'login_state.dart';

class LoginViewPhone extends StatelessWidget {
  static LoginController myLoginController = getIt<LoginController>();

  const LoginViewPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black54, body: LoginPanel());
  }
}

class LoginPanel extends ConsumerStatefulWidget {
  static LoginController myLoginController = getIt<LoginController>();
  const LoginPanel({super.key});

  @override
  ConsumerState<LoginPanel> createState() => _LoginPanelState();
}

class _LoginPanelState extends ConsumerState<LoginPanel> {
  final LoginController myLoginController = getIt<LoginController>();
  final TextEditingController usernameC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();
  final TextEditingController alC = TextEditingController();

  final TextEditingController emailC = TextEditingController();
  final TextEditingController forgetCodeC = TextEditingController();

  final FocusNode usernameFN = FocusNode();
  final FocusNode passwordFN = FocusNode();
  final FocusNode alFN = FocusNode();

  final TextEditingController newPasswordC = TextEditingController();
  final TextEditingController newPasswordConfirmC = TextEditingController();
  final FocusNode newPasswordFN = FocusNode();
  final FocusNode newPasswordConfirmFN = FocusNode();

  bool loadingLogin = false;
  bool forgetPasswordMode = false;
  bool codeSent = false;
  bool rememberMe = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myLoginController.onInit();
    });
    ref.read(usernameProvider.notifier).addListener((a) => usernameC.text = a);
    ref.read(passwordProvider.notifier).addListener((a) => passwordC.text = a);
    usernameC.addListener(() {
      if (usernameFN.hasFocus) return;
      ref.read(usernameProvider.notifier).update((s) => usernameC.text);
    });
    passwordC.addListener(() {
      if (passwordFN.hasFocus) return;
      ref.read(passwordProvider.notifier).update((s) => passwordC.text);
    });

    emailC.addListener(() => setState(() {}));
    newPasswordC.addListener(() => setState(() {}));
    newPasswordConfirmC.addListener(() => setState(() {}));
    forgetCodeC.addListener(() => setState(() {}));
    // WidgetsBinding.instance.addPostFrameCallback((_)=>usernameFN.requestFocus());
    super.initState();
  }

  @override
  void dispose() {
    usernameC.dispose();
    passwordC.dispose();
    alC.dispose();
    usernameFN.dispose();
    passwordFN.dispose();
    alFN.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    LoginState state = ref.read(loginProvider);
    return Container(
      // width: 300,
      width: context.width,
      // margin: const EdgeInsets.only(left: 24, right: 24, top: 72),
      decoration: BoxDecoration(
        color: MyColors.black8,
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          alignment: Alignment.bottomCenter,
          image: AssetImage(AssetImages.loginBg),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12)
            ),
            padding: const EdgeInsets.only(left: 24, right: 24, top: 0),
            margin: const EdgeInsets.only(top: 12),
            child: ListView(
              shrinkWrap: true,
              children: [
                Text("ABOMIS\nDOCUMENT\nCHECK", style: TextStyles.styleBold16Black.copyWith(fontSize: 36,height: 1,fontWeight: FontWeight.w800)),
                const SizedBox(height: 32),
                MyTextField(
                  label: "Username",
                  borderSide: BorderSide(color: MyColors.lineBorderColor),
                  controller: usernameC,
                  focusNode: usernameFN,
                  onSubmit: (v) {
                    FocusScope.of(context).requestFocus(passwordFN);
                  },
                ),
                const SizedBox(height: 24),
                MyTextField(
                  label: "Password",
                  borderSide: BorderSide(color: MyColors.lineBorderColor),
                  controller: passwordC,
                  focusNode: passwordFN,
                  isPassword: true,
                ),
                const SizedBox(height: 24),
                Consumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    LoginState state = ref.watch(loginProvider);
                    return MyButton(
                      height: 45,
                      onPressed: () async {
                        await myLoginController.login(usernameC.text,passwordC.text);
                      },
                      fontSize: 16,
                      label: 'Enter',
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
