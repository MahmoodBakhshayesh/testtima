import 'package:flutter/material.dart';
import 'users_controller.dart';
import 'users_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';


class UsersViewTablet extends StatelessWidget {
  static UsersController myUsersController = getIt<UsersController>();
  const UsersViewTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: UsersAppBarTablet(),
        body: Column(children: [

        ],));
  }
}

class UsersAppBarTablet extends StatelessWidget implements PreferredSizeWidget {
static UsersController myUsersController = getIt<UsersController>();

const UsersAppBarTablet({super.key});

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
"Users",
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
