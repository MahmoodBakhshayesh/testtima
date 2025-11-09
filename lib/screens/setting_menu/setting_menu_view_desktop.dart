import 'package:abds/core/classes/menu_class.dart';
import 'package:abds/core/interface_implementations/spiners.dart';
import 'package:abds/widgets/DotButton.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'setting_menu_controller.dart';
import 'setting_menu_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';
import 'widgets/setting_menu_widget.dart';

class SettingMenuViewDesktop extends ConsumerStatefulWidget {
  static SettingMenuController mySettingMenuController = getIt<SettingMenuController>();

  const SettingMenuViewDesktop({super.key});

  @override
  ConsumerState<SettingMenuViewDesktop> createState() => _SettingMenuViewDesktopState();
}

class _SettingMenuViewDesktopState extends ConsumerState<SettingMenuViewDesktop> {
  static SettingMenuController mySettingMenuController = getIt<SettingMenuController>();

  @override
  void initState() {
    mySettingMenuController.getMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SettingMenu? menu = ref.watch(settingMenuProvider);
    bool loading = ref.watch(menuLoadingProvider);
    return Scaffold(
      appBar: SettingMenuAppBarDesktop(),
      body: Column(
        children: [
          Expanded(
            child: menu != null ? SettingsMenuScreen(loading: loading, menu: menu, initialValuesByEndpoint: ref.watch(menuValuesProvider)) : SizedBox(),
          ),
        ],
      ),
    );
  }
}

class SettingMenuAppBarDesktop extends StatelessWidget implements PreferredSizeWidget {
  static SettingMenuController mySettingMenuController = getIt<SettingMenuController>();

  const SettingMenuAppBarDesktop({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(108);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: Colors.white,
      alignment: Alignment.center,
      child: SafeArea(
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
                      Text("Menu Setting", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                      Spacer(),
                      DotButton(
                        icon: Icons.refresh,
                        onPressed: () async {
                          await mySettingMenuController.getMenu();
                        },
                      ),
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
