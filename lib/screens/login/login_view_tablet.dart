import '../../initialize.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/MyButton.dart';
import '../../widgets/MyTextField.dart';
import 'login_controller.dart';
import 'login_state.dart';

class LoginViewTablet extends StatelessWidget {
  static LoginController myLoginController = getIt<LoginController>();
  const LoginViewTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.black54,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            LoginPanel(),
          ],
        ));
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
    ref.listen(usernameProvider, (o, n) => usernameC.text = n);
    ref.listen(passwordProvider, (o, n) => passwordC.text = n);
    return Container(
      width: 300,
      height: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        children: [
          const Text("Please Login"),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MyTextField(
                  label: "Username",
                  controller: usernameC,
                  validator: (v) {
                    if (v.isEmpty) {
                      return null;
                    } else if (v.length < 4) {
                      return "Too Short";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 12),
                MyTextField(label: "Password", controller: passwordC),
                const SizedBox(height: 12),
                Consumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    LoginState state = ref.watch(loginProvider);
                    return MyButton(
                      onPressed: () async {
                        await Future.delayed(const Duration(seconds: 2));
                      },
                      label: 'login',
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
