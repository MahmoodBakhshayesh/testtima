import 'package:flutter/material.dart';
import 'add_user_controller.dart';
import 'add_user_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';


class AddUserViewDesktop extends StatelessWidget {
  static AddUserController myAddUserController = getIt<AddUserController>();
  const AddUserViewDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AddUserAppBarDesktop(),
        body: Column(children: [

        ],));
  }
}

class AddUserAppBarDesktop extends StatelessWidget implements PreferredSizeWidget {
static AddUserController myAddUserController = getIt<AddUserController>();

const AddUserAppBarDesktop({super.key});

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
"AddUser",
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
