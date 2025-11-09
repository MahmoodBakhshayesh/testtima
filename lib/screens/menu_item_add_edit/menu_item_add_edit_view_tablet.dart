import 'package:flutter/material.dart';
import 'menu_item_add_edit_controller.dart';
import 'menu_item_add_edit_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';


class MenuItemAddEditViewTablet extends StatelessWidget {
  static MenuItemAddEditController myMenuItemAddEditController = getIt<MenuItemAddEditController>();
  const MenuItemAddEditViewTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: MenuItemAddEditAppBarTablet(),
        body: Column(children: [

        ],));
  }
}

class MenuItemAddEditAppBarTablet extends StatelessWidget implements PreferredSizeWidget {
static MenuItemAddEditController myMenuItemAddEditController = getIt<MenuItemAddEditController>();

const MenuItemAddEditAppBarTablet({super.key});

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
"MenuItemAddEdit",
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
