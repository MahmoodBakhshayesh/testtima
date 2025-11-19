import 'dart:developer';

import 'package:abds/core/classes/menu_class.dart';
import 'package:abds/core/interface_implementations/spiners.dart';
import 'package:abds/screens/home/home_drawer.dart';
import 'package:abds/widgets/DotButton.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/interfaces/failures_int.dart';
import '../../core/utils_and_services/handlers/failure_handler.dart';
import '../menu_item_add_edit/menu_item_add_edit_controller.dart';
import '../menu_item_add_edit/menu_item_add_edit_state.dart';
import '../menu_item_add_edit/menu_item_add_edit_view_desktop.dart';
import '../menu_item_add_edit/menu_item_add_edit_view_phone.dart';
import '../menu_section/menu_section_controller.dart';
import '../menu_section/menu_section_state.dart';
import '../menu_section/menu_section_view_phone.dart';
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
      appBar: SettingMenuAppBarDesktop(),
      body: Column(
        children: [Expanded(child: menu != null ? SettingMenuDesktopWidget(menu: menu) : SizedBox())],
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

class SettingMenuDesktopWidget extends ConsumerStatefulWidget {
  final SettingMenu menu;

  const SettingMenuDesktopWidget({super.key, required this.menu});

  @override
  ConsumerState<SettingMenuDesktopWidget> createState() => _SettingMenuDesktopWidgetState();
}

class _SettingMenuDesktopWidgetState extends ConsumerState<SettingMenuDesktopWidget> {
  @override
  Widget build(BuildContext context) {
    MenuDescriptor? section = ref.watch(menuSectionProvider);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            ...widget.menu.sections.map((s) {
              bool selected = section == s;
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                width: 300,
                child: DrawerAction(
                  radius: 10,
                  title: s.title,
                  trailing: Icon(Icons.arrow_forward_ios_sharp,size: 15,),
                  tileColor: selected?Colors.blueAccent.withOpacity(0.3):null,
                  borderColor: selected?Colors.blueAccent:null,
                  onTap: () async {
                    await getIt<SettingMenuController>().loadData(s);
                  },
                ),
              );
            }),
          ],
        ),
        Expanded(
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              MenuDescriptor? section = ref.watch(menuSectionProvider);
              if (section == null) {
                log("section ${section}");
                return SizedBox();
              }
              return MenuSectionWidgetDesktop(section: section);
            },
          ),
        ),
        Expanded(
          flex: 2,
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              MenuDescriptor? section = ref.watch(menuSectionProvider);
              if (section == null) {
                log("section ${section}");
                return SizedBox();
              }
              return EditingSectionWidgetDesktop();
            },
          ),
        ),
      ],
    );
  }
}

class MenuSectionWidgetDesktop extends ConsumerStatefulWidget {
  final MenuDescriptor section;

  const MenuSectionWidgetDesktop({super.key, required this.section});

  @override
  ConsumerState<MenuSectionWidgetDesktop> createState() => _MenuSectionWidgetDesktopState();
}

class _MenuSectionWidgetDesktopState extends ConsumerState<MenuSectionWidgetDesktop> {
  @override
  Widget build(BuildContext context) {
    final section = ref.watch(menuSectionProvider)!;
    final items = ref.watch(sectionItemsProvider);
    log("secion ${widget.section}");
    log("items ${items.length}");
    return Container(
      decoration: BoxDecoration(color: Colors.blueAccent.withOpacity(0.05)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: Text(section.title)),

                MyButton(
                  label: "Add",
                  onPressed: () {
                    getIt<MenuSectionController>().addItem(section.schema, "New ${section.title.split(" ").last}", context.isDesktop);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (c, i) {
                String label = section.title.split(" ").last;
                return SectionItemWidget(data: items[i], schema: section.schema, label: '${label} ${i + 1}');
              },
            ),
          ),
        ],
      ),
    );
  }
}

class EditingSectionWidgetDesktop extends ConsumerStatefulWidget {
  const EditingSectionWidgetDesktop({super.key});

  @override
  ConsumerState<EditingSectionWidgetDesktop> createState() => _EditingSectionWidgetDesktopState();
}

class _EditingSectionWidgetDesktopState extends ConsumerState<EditingSectionWidgetDesktop> {
  static MenuItemAddEditController myMenuItemAddEditController = getIt<MenuItemAddEditController>();
  dynamic changed;

  onSubmit(SchemaNode schema) async {
    final errors = validateAgainstSchema(ref.watch(editingSchemaProvider)!, changed);
    if (errors.isNotEmpty) {
      FailureHandler.handle(ValidationFailure(code: -1, msg: errors.join("\n"), traceMsg: errors.join("\n")));
      return;
    }
    log(changed.runtimeType.toString());
    if(changed is Map){
      log("changed is Map and ${(changed as Map).containsKey("_id") }");
      if ((changed as Map).containsKey("_id") && (changed as Map)["_id"].toString().isNotEmpty) {
        await myMenuItemAddEditController.saveItem(schema, changed,context.isDesktop);
      } else {
        await myMenuItemAddEditController.addItem(schema, changed,context.isDesktop);
      }
    }else if(changed is List){
      log("changed is list Map and ${(changed[0] as Map).containsKey("_id")}");

      if ((changed[0] as Map).containsKey("_id") && (changed[0] as Map)["_id"].toString().isNotEmpty) {
        await myMenuItemAddEditController.saveItem(schema, changed,context.isDesktop);


      } else {
        await myMenuItemAddEditController.addItem(schema, changed,context.isDesktop);
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    final editing = Map<String, dynamic>.from(ref.watch(editingMenuProvider) ?? {});
    final editingSchema = ref.watch(editingSchemaProvider);
    final editingLabel = ref.watch(editingLabelProvider);
    if (editingSchema == null ) {
      return SizedBox();
    }

    return MenuItemAddEditViewDesktop();
    return Container(
      decoration: BoxDecoration(color: Colors.greenAccent.withOpacity(.1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
            child: Row(
              children: [
                Spacer(),
                MyButton(label: editing.containsKey("_id") ? "Edit" : "Add", onPressed:() async => await onSubmit(editingSchema!)),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  EditingItemWidget(
                    onChange: (up) {
                      changed = up;
                      setState(() {});
                    },
                    schema: editingSchema!,
                    data: editing,
                    label: editingLabel!,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
