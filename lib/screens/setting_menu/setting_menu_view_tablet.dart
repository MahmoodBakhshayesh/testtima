import 'package:flutter/material.dart';
import 'setting_menu_controller.dart';
import 'setting_menu_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';


class SettingMenuViewTablet extends StatelessWidget {
  static SettingMenuController mySettingMenuController = getIt<SettingMenuController>();
  const SettingMenuViewTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: SettingMenuAppBarTablet(),
        body: Column(children: [

        ],));
  }
}

class SettingMenuAppBarTablet extends StatelessWidget implements PreferredSizeWidget {
static SettingMenuController mySettingMenuController = getIt<SettingMenuController>();

const SettingMenuAppBarTablet({super.key});

@override
Size get preferredSize => const Size.fromHeight(108);

@override
Widget build(BuildContext context) {
return Container(
height: preferredSize.height,
color: context.mainColor,
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
Text(
"SettingMenu",
style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18),
),
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
