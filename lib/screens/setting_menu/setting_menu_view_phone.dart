import 'package:abds/core/classes/menu_class.dart';
import 'package:abds/core/interface_implementations/spiners.dart';
import 'package:abds/core/navigation/routes.dart';
import 'package:abds/screens/home/home_drawer.dart';
import 'package:abds/screens/menu_section/menu_section_state.dart';
import 'package:abds/widgets/DotButton.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'setting_menu_controller.dart';
import 'setting_menu_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';
import 'widgets/setting_menu_widget.dart';

class SettingMenuViewPhone extends ConsumerStatefulWidget {
  static SettingMenuController mySettingMenuController = getIt<SettingMenuController>();

  const SettingMenuViewPhone({super.key});

  @override
  ConsumerState<SettingMenuViewPhone> createState() => _SettingMenuViewPhoneState();
}

class _SettingMenuViewPhoneState extends ConsumerState<SettingMenuViewPhone> {
  static SettingMenuController mySettingMenuController = getIt<SettingMenuController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mySettingMenuController.getMenu();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SettingMenu? menu = ref.watch(settingMenuProvider);
    bool loading = ref.watch(menuLoadingProvider);
    return Scaffold(
      appBar: SettingMenuAppBarPhone(),
      body:menu==null?SizedBox(): ListView.builder(
        itemCount: menu!.sections.length,
        itemBuilder: (c, i) {
          final sec = menu!.sections[i];
          return MenuSectionWidget(section: sec);
        },
      ),
    );
  }
}

class MenuSectionWidget extends StatelessWidget {
  final MenuDescriptor section;

  const MenuSectionWidget({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
      child: DrawerAction(
        title: section.fieldTitle,
        subtitle: Text(section.fieldDescription),
        onTap: () async {
          final smC = getIt<SettingMenuController>();
          final items = await smC.loadData(section);
          if(items !=null){
            smC.ref.read(menuSectionProvider.notifier).update((s)=>section);
            smC.ref.read(sectionItemsProvider.notifier).update((s)=>items);
            smC.goNamed(Routes.menuSection);
          }
        },
        tileColor: Colors.white,
        trailing: Icon(Icons.arrow_forward_ios_sharp),
      ),
    );
  }
}

class SettingMenuAppBarPhone extends StatelessWidget implements PreferredSizeWidget {
  static SettingMenuController mySettingMenuController = getIt<SettingMenuController>();

  const SettingMenuAppBarPhone({super.key});

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
