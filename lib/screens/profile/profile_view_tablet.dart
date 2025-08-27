import 'package:flutter/material.dart';
import 'profile_controller.dart';
import 'profile_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';


class ProfileViewTablet extends StatelessWidget {
  static ProfileController myProfileController = getIt<ProfileController>();
  const ProfileViewTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: ProfileAppBarTablet(),
        body: Column(children: [

        ],));
  }
}

class ProfileAppBarTablet extends StatelessWidget implements PreferredSizeWidget {
static ProfileController myProfileController = getIt<ProfileController>();

const ProfileAppBarTablet({super.key});

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
"Profile",
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
