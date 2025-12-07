import 'package:flutter/material.dart';
import 'menu_section_controller.dart';
import 'menu_section_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';

class MenuSectionViewDesktop extends StatelessWidget {
  static MenuSectionController myMenuSectionController = getIt<MenuSectionController>();

  const MenuSectionViewDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MenuSectionAppBarDesktop(),
      body: Column(children: []),
    );
  }
}

class MenuSectionAppBarDesktop extends StatelessWidget implements PreferredSizeWidget {
  static MenuSectionController myMenuSectionController = getIt<MenuSectionController>();

  const MenuSectionAppBarDesktop({super.key});

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
                        "MenuSection",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
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
