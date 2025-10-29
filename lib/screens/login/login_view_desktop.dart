import 'dart:developer';

import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/core/utils_and_services/artemis_icons_icons.dart';
import 'package:abds/core/utils_and_services/button_keys.dart';
import 'package:abds/core/utils_and_services/icomoon_layered_presets_from_css.dart';
import 'package:abds/widgets/primary_action_widget.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:pinput/pinput.dart';

import '../../core/constants/assest.dart';
import '../../core/constants/ui.dart';
import '../../core/interfaces/success_int.dart';
import '../../core/utils_and_services/app_config.dart';
import '../../core/utils_and_services/handlers/success_handler.dart';
import '../../core/utils_and_services/resent_timer_controller.dart';
import '../../initialize.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/DotButton.dart';
import '../../widgets/MyButton.dart';
import '../../widgets/MyTextField.dart';
import '../../widgets/native_drop_down.dart';
import 'login_controller.dart';
import 'login_state.dart';

class LoginViewDesktop extends StatefulWidget {
  static LoginController myLoginController = getIt<LoginController>();

  const LoginViewDesktop({super.key});

  @override
  State<LoginViewDesktop> createState() => _LoginViewDesktopState();
}

class _LoginViewDesktopState extends State<LoginViewDesktop> {
  static LoginController myLoginController = getIt<LoginController>();

  @override
  initState() {
    myLoginController.initLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: DotButton(
              size: 40,
              // fade: false,
              flat: true,
              backgroundColor: Colors.transparent,
              border: BorderSide(color: MyColors.mainBlue.withOpacity(0.3)),
              onPressed: () async {
                await LoginViewDesktop.myLoginController.serverSelect();
                // myLoginController.showLoginSetting();
              },
              child: IcomoonLayeredCss.cloud_connection(colors: [MyColors.mainBlue.withOpacity(0.3),MyColors.mainBlue]),
              icon: Icons.settings_remote_rounded,
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black54,
      body: Container(
          color: Colors.white,
          child: Center(child: SizedBox(
              width: 500,
                height: 500,

              child: LoginPanel()
          ))),
    );
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
  late ResendTimerController controller;

  bool loadingLogin = false;
  bool forgetPasswordMode = false;
  bool codeSent = false;
  bool rememberMe = true;
  bool codeEntered = false;

  int viewIndex = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myLoginController.onInit();
    });
    controller = ResendTimerController(maxSeconds: 60);

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

  unFocus() {
    FocusScope.of(context).requestFocus(FocusNode());
  }



  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      width: context.width,
      decoration: BoxDecoration(
        color: Color(0xffF0F5F8),
        borderRadius: BorderRadius.circular(12),
        // image: const DecorationImage(alignment: Alignment.bottomCenter, image: AssetImage(AssetImages.loginBg), fit: BoxFit.cover),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      child: IndexedStack(
        index: viewIndex,
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.only(left: 24, right: 24, top: 0),
                margin: const EdgeInsets.only(top: 12),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Row(
                      children: [
                        Image.asset(AssetImages.logo,height: 50,),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text("TimaCheck", style: TextStyles.styleBold16Black.copyWith(fontSize: 36, height: 1, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 24),

                    MyTextField(
                      label: "Username or Email",
                      borderSide: BorderSide(color: Colors.white),
                      controller: usernameC,
                      focusNode: usernameFN,
                      keyboardType: TextInputType.emailAddress,
                      onSubmit: (v) {
                        FocusScope.of(context).requestFocus(passwordFN);
                      },
                    ),
                    const SizedBox(height: 12),
                    MyTextField(
                      label: "Password",
                      borderSide: BorderSide(color: Colors.white),
                      controller: passwordC,
                      focusNode: passwordFN,
                      isPassword: true,
                    ),
                    Row(
                      children: [
                        MyButton(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          label: "Forgot Password",
                          onPressed: () {
                            viewIndex = 1;
                            unFocus();
                            setState(() {});
                          },
                          reverse: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Consumer(
                      builder: (BuildContext context, WidgetRef ref, Widget? child) {
                        LoginState state = ref.watch(loginProvider);
                        return MyButton(

                          height: 45,
                          radius: 12,
                          onPressed: () async {
                            await myLoginController.login(usernameC.text, passwordC.text);
                          },
                          fontSize: 16,
                          key: ButtonKeys.loginButtonKey,
                          label: 'Sign In',
                          child: Row(children: [
                            Expanded(child: Text("Sign In",style: TextStyle(color: Colors.white),)),
                            IcomoonLayeredCss.user_octagon(colors: [Colors.white38,Colors.white,Colors.white]),
                          ],),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.only(left: 24, right: 24, top: 0),
            margin: const EdgeInsets.only(top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),
                Text("Forget\nPassword", style: TextStyles.styleBold16Black.copyWith(fontSize: 36, height: 1, fontWeight: FontWeight.w800)),
                const SizedBox(height: 32),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        DotButton(
                          icon: Icons.arrow_left,
                          onPressed: () {
                            codeSent = false;
                            controller.cancel();
                            forgetCodeC.clear();
                            forgetPasswordMode = false;
                            viewIndex = 0;
                            setState(() {});
                          },
                          color: Colors.white,
                          border: BorderSide(color: MyColors.lineColor),
                          child: Icon(Icons.arrow_left, color: Colors.black),
                        ),
                        const SizedBox(width: 12),
                        Text("Enter Your Email", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 32),
                    MyTextField(label: "Email", placeholder: "", keyboardType: TextInputType.emailAddress, controller: emailC, onSubmit: (v) {}),
                    const SizedBox(height: 48),
                    Consumer(
                      builder: (BuildContext context, WidgetRef ref, Widget? child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyButton(
                              height: 45,
                              color: Theme.of(context).primaryColor,
                              borderSide: BorderSide(color: context.mainColor),
                              onPressed: !emailC.text.isEmail
                                  ? null
                                  : () async {
                                final res = await LoginPanel.myLoginController.sendForgetPasswordCode(emailC.text);
                                if (res != null) {
                                  forgetCodeC.clear();
                                  codeSent = true;
                                  controller.start();
                                  viewIndex = 2;
                                  setState(() {});
                                }
                              },
                              fontSize: 16,
                              label: 'Send Code',
                            ),
                            const SizedBox(height: 8),
                          ],
                        );
                      },
                    ),

                    // Consumer(
                    //   builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    //     return MyButton(
                    //       height: 45,
                    //       onPressed: () async {
                    //         myLoginController.goNamed(Routes.offlineBoarding);
                    //       },
                    //       fontSize: 16,
                    //       label: 'Offline Boarding',
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.only(left: 24, right: 24, top: 0),
            margin: const EdgeInsets.only(top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),
                Text("Forget\nPassword", style: TextStyles.styleBold16Black.copyWith(fontSize: 36, height: 1, fontWeight: FontWeight.w800)),
                const SizedBox(height: 32),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        DotButton(
                          icon: Icons.arrow_left,
                          onPressed: () {
                            codeSent = false;
                            controller.cancel();
                            forgetCodeC.clear();
                            forgetPasswordMode = false;
                            viewIndex = 1;
                            unFocus();
                            setState(() {});
                          },
                          color: Colors.white,
                          border: BorderSide(color: MyColors.lineColor),
                          child: Icon(Icons.arrow_left, color: Colors.black),
                        ),
                        const SizedBox(width: 12),
                        Text("Check Your Inbox", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Padding(padding: const EdgeInsets.only(right: 8.0), child: Icon(Icons.email, size: 15)),
                        Expanded(
                          child: Text("${emailC.text}", style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text("We've sent a verification link to your inbox. Please click on the link contained in the email"),
                    const SizedBox(height: 16),
                    Pinput(
                      length: 6,
                      controller: forgetCodeC,
                      defaultPinTheme: PinTheme(
                        textStyle: TextStyle(fontSize: 18),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                        constraints: BoxConstraints(minHeight: 55),
                      ),
                      autofocus: viewIndex==2,
                      onCompleted: (a) {
                        viewIndex++;

                        unFocus();
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 24),
                    AnimatedBuilder(
                      animation: controller,
                      builder: (_, __) {
                        return Row(
                          children: [
                            Expanded(child: Text("Haven't received any link?\nResend in ${controller.remaining}s")),
                            MyButton(
                              height: 40,
                              color: Theme.of(context).primaryColor,
                              onPressed: controller.isRunning
                                  ? null
                                  : () async {
                                final res = await LoginPanel.myLoginController.sendForgetPasswordCode(emailC.text);
                                if (res != null) {
                                  codeSent = true;
                                  forgetCodeC.clear();
                                  controller.start();
                                  unFocus();
                                  setState(() {});
                                }
                              },
                              borderSide: BorderSide(color: Theme.of(context).primaryColor),
                              fontSize: 14,
                              reverse: true,
                              label: 'Resend',
                              icon: Icons.refresh,
                            ),
                          ],
                        );
                      },
                    ),

                    // Consumer(
                    //   builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    //     return MyButton(
                    //       height: 45,
                    //       onPressed: () async {
                    //         myLoginController.goNamed(Routes.offlineBoarding);
                    //       },
                    //       fontSize: 16,
                    //       label: 'Offline Boarding',
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.only(left: 24, right: 24, top: 0),
            margin: const EdgeInsets.only(top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),
                Text("Reset\nPassword", style: TextStyles.styleBold16Black.copyWith(fontSize: 36, height: 1, fontWeight: FontWeight.w800)),
                const SizedBox(height: 32),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 16),
                        MyTextField(
                          label: "New Password",
                          placeholder: "",
                          controller: newPasswordC,
                          focusNode: newPasswordFN,
                          isPassword: true,
                          onSubmit: (a) {
                            FocusScope.of(context).requestFocus(newPasswordConfirmFN);
                          },
                        ),
                        const SizedBox(height: 16),
                        MyTextField(
                          label: "Repeat Password",
                          placeholder: "",
                          controller: newPasswordConfirmC,
                          focusNode: newPasswordConfirmFN,
                          validator: (a) {
                            if (a.isNotEmpty && newPasswordC.text.isNotEmpty && a != newPasswordC.text) {
                              return "Passwords does not match";
                            }
                          },
                          isPassword: true,
                        ),
                        const SizedBox(height: 32),
                        Consumer(
                          builder: (BuildContext context, WidgetRef ref, Widget? child) {
                            return MyButton(
                              height: 45,
                              color: Theme.of(context).primaryColor,
                              borderSide: BorderSide(color: Theme.of(context).primaryColor),
                              onPressed: forgetCodeC.text.length < 6 || newPasswordC.text.isEmpty || newPasswordC.text != newPasswordConfirmC.text
                                  ? null
                                  : () async {
                                final res = await LoginPanel.myLoginController.resetPassword(email: emailC.text, newPass: newPasswordC.text, code: forgetCodeC.text);
                                if (res != null) {
                                  SuccessHandler.handle(ServerSuccess(code: 1, msg: "Password set successfully!"));
                                  forgetPasswordMode = false;
                                  codeSent = false;
                                  forgetCodeC.clear();
                                  controller.start();
                                  viewIndex = 0;
                                  unFocus();
                                  setState(() {});
                                }
                              },
                              fontSize: 16,
                              label: 'Change Password',
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Container(
      width: context.width,
      decoration: BoxDecoration(
        color: MyColors.black8,
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(alignment: Alignment.bottomCenter, image: AssetImage(AssetImages.loginBg), fit: BoxFit.cover),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      child: forgetPasswordMode
          ? codeSent
          ? codeEntered
          ? Container()
          : Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.only(left: 24, right: 24, top: 0),
        margin: const EdgeInsets.only(top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48),
            Text("FORGET\nPASSWORD", style: TextStyles.styleBold16Black.copyWith(fontSize: 36, height: 1, fontWeight: FontWeight.w800)),
            const SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Row(
                  children: [
                    DotButton(
                      icon: Icons.arrow_left,
                      onPressed: () {
                        codeSent = false;
                        controller.cancel();
                        forgetCodeC.clear();
                        forgetPasswordMode = false;
                        setState(() {});
                      },
                      color: Colors.white,
                      border: BorderSide(color: MyColors.lineColor),
                      child: Icon(Icons.arrow_left, color: Colors.black),
                    ),
                    const SizedBox(width: 12),
                    Text("Enter Your Email", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 16),
                MyTextField(label: "Email", placeholder: "", locked: codeSent, keyboardType: TextInputType.emailAddress, controller: emailC, onSubmit: (v) {}),
                const SizedBox(height: 16),
                Visibility(
                  visible: !codeSent,
                  child: Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyButton(
                            height: 45,
                            color: Theme.of(context).primaryColor,
                            borderSide: BorderSide(color: context.mainColor),
                            onPressed: !emailC.text.isEmail
                                ? null
                                : () async {
                              final res = await LoginPanel.myLoginController.sendForgetPasswordCode(emailC.text);
                              if (res != null) {
                                forgetCodeC.clear();
                                codeSent = true;
                                controller.start();
                                setState(() {});
                              }
                            },
                            fontSize: 16,
                            label: 'Send Code',
                          ),
                          const SizedBox(height: 8),
                          // Row(
                          //   children: [
                          //     MyButton(
                          //       height: 40,
                          //       color: Theme.of(context).primaryColor,
                          //       onPressed: () {
                          //         codeSent = false;
                          //         controller.cancel();
                          //         forgetCodeC.clear();
                          //         forgetPasswordMode = false;
                          //         setState(() {});
                          //       },
                          //       fontSize: 14,
                          //       reverse: true,
                          //       label: "Back to login",
                          //     ),
                          //   ],
                          // ),
                        ],
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: codeSent,
                  child: Column(
                    children: [
                      Pinput(
                        length: 6,
                        controller: forgetCodeC,
                        autofocus: true,
                        onCompleted: (a) {
                          FocusScope.of(context).requestFocus(newPasswordFN);
                        },
                      ),
                      const SizedBox(height: 16),
                      MyTextField(
                        label: "Password",
                        placeholder: "",
                        controller: newPasswordC,
                        focusNode: newPasswordFN,
                        isPassword: true,
                        onSubmit: (a) {
                          FocusScope.of(context).requestFocus(newPasswordConfirmFN);
                        },
                      ),
                      const SizedBox(height: 8),
                      MyTextField(
                        label: "Password Confirm",
                        placeholder: "",
                        controller: newPasswordConfirmC,
                        focusNode: newPasswordConfirmFN,
                        validator: (a) {
                          if (a.isNotEmpty && newPasswordC.text.isNotEmpty && a != newPasswordC.text) {
                            return "Passwords does not match";
                          }
                        },
                        isPassword: true,
                      ),
                      const SizedBox(height: 12),
                      Consumer(
                        builder: (BuildContext context, WidgetRef ref, Widget? child) {
                          return MyButton(
                            height: 45,
                            color: Theme.of(context).primaryColor,
                            onPressed: forgetCodeC.text.length < 6 || newPasswordC.text.isEmpty || newPasswordC.text != newPasswordConfirmC.text
                                ? null
                                : () async {
                              final res = await LoginPanel.myLoginController.resetPassword(email: emailC.text, newPass: newPasswordC.text, code: forgetCodeC.text);
                              if (res != null) {
                                SuccessHandler.handle(ServerSuccess(code: 1, msg: "Password set successfully!"));
                                forgetPasswordMode = false;
                                codeSent = false;
                                forgetCodeC.clear();
                                controller.start();
                                setState(() {});
                              }
                            },
                            fontSize: 16,
                            label: 'Set Password',
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      Consumer(
                        builder: (BuildContext context, WidgetRef ref, Widget? child) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  AnimatedBuilder(
                                    animation: controller,
                                    builder: (_, __) {
                                      return MyButton(
                                        height: 40,
                                        color: Theme.of(context).primaryColor,
                                        onPressed: controller.isRunning
                                            ? null
                                            : () async {
                                          final res = await LoginPanel.myLoginController.sendForgetPasswordCode(emailC.text);
                                          if (res != null) {
                                            codeSent = true;
                                            forgetCodeC.clear();
                                            controller.start();
                                            setState(() {});
                                          }
                                        },
                                        fontSize: 14,
                                        reverse: true,
                                        label: controller.isRunning ? 'Resend in ${controller.remaining}s' : 'Resend Code',
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  MyButton(
                                    height: 40,
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () async {
                                      codeSent = false;
                                      forgetCodeC.clear();
                                      controller.cancel();
                                      setState(() {});
                                    },
                                    fontSize: 14,
                                    reverse: true,
                                    label: 'Change Email',
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // Consumer(
                //   builder: (BuildContext context, WidgetRef ref, Widget? child) {
                //     return MyButton(
                //       height: 45,
                //       onPressed: () async {
                //         myLoginController.goNamed(Routes.offlineBoarding);
                //       },
                //       fontSize: 16,
                //       label: 'Offline Boarding',
                //     );
                //   },
                // ),
              ],
            ),
          ],
        ),
      )
          : Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.only(left: 24, right: 24, top: 0),
        margin: const EdgeInsets.only(top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48),
            Text("FORGET\nPASSWORD", style: TextStyles.styleBold16Black.copyWith(fontSize: 36, height: 1, fontWeight: FontWeight.w800)),
            const SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Row(
                  children: [
                    DotButton(
                      icon: Icons.arrow_left,
                      onPressed: () {
                        codeSent = false;
                        controller.cancel();
                        forgetCodeC.clear();
                        forgetPasswordMode = false;
                        setState(() {});
                      },
                      color: Colors.white,
                      border: BorderSide(color: MyColors.lineColor),
                      child: Icon(Icons.arrow_left, color: Colors.black),
                    ),
                    const SizedBox(width: 12),
                    Text("Check Your Inbox", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 16),
                MyTextField(label: "Email", placeholder: "", locked: codeSent, keyboardType: TextInputType.emailAddress, controller: emailC, onSubmit: (v) {}),
                const SizedBox(height: 16),
                Visibility(
                  visible: !codeSent,
                  child: Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyButton(
                            height: 45,
                            color: Theme.of(context).primaryColor,
                            borderSide: BorderSide(color: context.mainColor),
                            onPressed: !emailC.text.isEmail
                                ? null
                                : () async {
                              final res = await LoginPanel.myLoginController.sendForgetPasswordCode(emailC.text);
                              if (res != null) {
                                forgetCodeC.clear();
                                codeSent = true;
                                controller.start();
                                setState(() {});
                              }
                            },
                            fontSize: 16,
                            label: 'Send Code',
                          ),
                          const SizedBox(height: 8),
                          // Row(
                          //   children: [
                          //     MyButton(
                          //       height: 40,
                          //       color: Theme.of(context).primaryColor,
                          //       onPressed: () {
                          //         codeSent = false;
                          //         controller.cancel();
                          //         forgetCodeC.clear();
                          //         forgetPasswordMode = false;
                          //         setState(() {});
                          //       },
                          //       fontSize: 14,
                          //       reverse: true,
                          //       label: "Back to login",
                          //     ),
                          //   ],
                          // ),
                        ],
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: codeSent,
                  child: Column(
                    children: [
                      Pinput(
                        length: 6,
                        controller: forgetCodeC,
                        autofocus: true,
                        onCompleted: (a) {
                          FocusScope.of(context).requestFocus(newPasswordFN);
                        },
                      ),
                      const SizedBox(height: 16),
                      MyTextField(
                        label: "Password",
                        placeholder: "",
                        controller: newPasswordC,
                        focusNode: newPasswordFN,
                        isPassword: true,
                        onSubmit: (a) {
                          FocusScope.of(context).requestFocus(newPasswordConfirmFN);
                        },
                      ),
                      const SizedBox(height: 8),
                      MyTextField(
                        label: "Password Confirm",
                        placeholder: "",
                        controller: newPasswordConfirmC,
                        focusNode: newPasswordConfirmFN,
                        validator: (a) {
                          if (a.isNotEmpty && newPasswordC.text.isNotEmpty && a != newPasswordC.text) {
                            return "Passwords does not match";
                          }
                        },
                        isPassword: true,
                      ),
                      const SizedBox(height: 12),
                      Consumer(
                        builder: (BuildContext context, WidgetRef ref, Widget? child) {
                          return MyButton(
                            height: 45,
                            color: Theme.of(context).primaryColor,
                            onPressed: forgetCodeC.text.length < 6 || newPasswordC.text.isEmpty || newPasswordC.text != newPasswordConfirmC.text
                                ? null
                                : () async {
                              final res = await LoginPanel.myLoginController.resetPassword(email: emailC.text, newPass: newPasswordC.text, code: forgetCodeC.text);
                              if (res != null) {
                                SuccessHandler.handle(ServerSuccess(code: 1, msg: "Password set successfully!"));
                                forgetPasswordMode = false;
                                codeSent = false;
                                forgetCodeC.clear();
                                controller.start();
                                setState(() {});
                              }
                            },
                            fontSize: 16,
                            label: 'Set Password',
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      Consumer(
                        builder: (BuildContext context, WidgetRef ref, Widget? child) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  AnimatedBuilder(
                                    animation: controller,
                                    builder: (_, __) {
                                      return MyButton(
                                        height: 40,
                                        color: Theme.of(context).primaryColor,
                                        onPressed: controller.isRunning
                                            ? null
                                            : () async {
                                          final res = await LoginPanel.myLoginController.sendForgetPasswordCode(emailC.text);
                                          if (res != null) {
                                            codeSent = true;
                                            forgetCodeC.clear();
                                            controller.start();
                                            setState(() {});
                                          }
                                        },
                                        fontSize: 14,
                                        reverse: true,
                                        label: controller.isRunning ? 'Resend in ${controller.remaining}s' : 'Resend Code',
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  MyButton(
                                    height: 40,
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () async {
                                      codeSent = false;
                                      forgetCodeC.clear();
                                      controller.cancel();
                                      setState(() {});
                                    },
                                    fontSize: 14,
                                    reverse: true,
                                    label: 'Change Email',
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // Consumer(
                //   builder: (BuildContext context, WidgetRef ref, Widget? child) {
                //     return MyButton(
                //       height: 45,
                //       onPressed: () async {
                //         myLoginController.goNamed(Routes.offlineBoarding);
                //       },
                //       fontSize: 16,
                //       label: 'Offline Boarding',
                //     );
                //   },
                // ),
              ],
            ),
          ],
        ),
      )
          : Column(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.only(left: 24, right: 24, top: 0),
            margin: const EdgeInsets.only(top: 12),
            child: ListView(
              shrinkWrap: true,
              children: [
                Text("ABOMIS\nDOCUMENT\nCHECK", style: TextStyles.styleBold16Black.copyWith(fontSize: 36, height: 1, fontWeight: FontWeight.w800)),
                const SizedBox(height: 32),
                MyTextField(
                  label: "Username",
                  borderSide: BorderSide(color: Colors.white),
                  controller: usernameC,
                  focusNode: usernameFN,
                  onSubmit: (v) {
                    FocusScope.of(context).requestFocus(passwordFN);
                  },
                ),
                const SizedBox(height: 12),
                MyTextField(
                  label: "Password",
                  borderSide: BorderSide(color: Colors.white),
                  controller: passwordC,
                  focusNode: passwordFN,
                  isPassword: true,
                ),
                Row(
                  children: [
                    MyButton(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      label: "Forget Password",
                      onPressed: () {
                        forgetPasswordMode = true;
                        setState(() {});
                      },
                      reverse: true,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Consumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    LoginState state = ref.watch(loginProvider);
                    return MyButton(
                      height: 45,
                      onPressed: () async {
                        await myLoginController.login(usernameC.text, passwordC.text);
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


class DefaultEnterScope extends StatelessWidget {
  const DefaultEnterScope({super.key, required this.onActivate, required this.child});
  final VoidCallback onActivate;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
        SingleActivator(LogicalKeyboardKey.numpadEnter): ActivateIntent(),
      },
      child: Actions(
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (intent) {
              onActivate();
              return null;
            },
          ),
        },
        child: Focus(autofocus: false, child: child),
      ),
    );
  }
}