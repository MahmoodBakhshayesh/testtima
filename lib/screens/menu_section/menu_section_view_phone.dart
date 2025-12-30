import 'dart:convert';
import 'dart:developer';

import 'package:abds/core/classes/menu_class.dart';
import 'package:abds/screens/setting_menu/setting_menu_controller.dart';
import 'package:abds/widgets/DotButton.dart';
import 'package:abds/widgets/MyExpansionTile.dart';
import 'package:abds/widgets/MyTextFieldNew.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../widgets/MyButton.dart';
import 'menu_section_controller.dart';
import 'menu_section_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';

final headerBgColor = Colors.blue.withOpacity(0.3);
final bodyBgColor = Colors.blue.withOpacity(0.15);

class MenuSectionViewPhone extends ConsumerStatefulWidget {
  static MenuSectionController myMenuSectionController = getIt<MenuSectionController>();

  const MenuSectionViewPhone({super.key});

  @override
  ConsumerState<MenuSectionViewPhone> createState() => _MenuSectionViewPhoneState();
}

class _MenuSectionViewPhoneState extends ConsumerState<MenuSectionViewPhone> {
  @override
  Widget build(BuildContext context) {
    final section = ref.watch(menuSectionProvider)!;
    final items = ref.watch(sectionItemsProvider);
    return Scaffold(
      appBar: MenuSectionAppBarPhone(section: section),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (c, i) {
                // String label = section.title.split(" ").last;
                String label = "";
                if (items.isNotEmpty && items.first is Map) {
                  for (var a in section.fieldName) {
                    label = label + " ${items[i][a]}";
                  }
                } else {
                  label = section.fieldTitle.split(" ").last + " ${i + 1}";
                }
                log("${section.fieldTitle} -- ${section.documentAccess.edit}");
                return SectionItemWidget(
                  data: items[i],
                  schema: section.schema,
                  label: label,
                  section: section,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MenuSectionAppBarPhone extends StatelessWidget implements PreferredSizeWidget {
  final MenuDescriptor section;
  static MenuSectionController myMenuSectionController = getIt<MenuSectionController>();

  const MenuSectionAppBarPhone({super.key, required this.section});

  @override
  Size get preferredSize => const Size.fromHeight(150);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: Colors.white,
      alignment: Alignment.center,
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          BackButton(),
                          Text(section.fieldTitle, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                          Spacer(),
                          // DotButton(
                          //   icon: Icons.add,
                          //   onPressed: () {
                          //     getIt<MenuSectionController>().addItem(section.schema, "New ${section.title.split(" ").last}", context.isDesktop);
                          //   },
                          // ),
                          SizedBox(width: 8),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                spacing: 8,
                children: [
                  ?section.collectionAccess.getTemplate
                      ? Expanded(
                          child: MyButton(
                            label: "Template",
                            icon: Icons.download,
                            onPressed: () async {
                              final mySettingMenuController = getIt<SettingMenuController>();
                              await mySettingMenuController.getMenuTemplate(section);
                            },
                          ),
                        )
                      : null,
                  ?section.collectionAccess.getCollectionAsExcel
                      ? DotButton(
                          size: 40,
                          color: Colors.green,
                          icon: Icons.download,
                          onPressed: () async {
                            final mySettingMenuController = getIt<SettingMenuController>();
                            await mySettingMenuController.getMenuAsExcel(section);
                          },
                        )
                      : null,
                  ?section.collectionAccess.addWithExcel
                      ? Expanded(
                          child: MyButton(
                            label: "Excel",
                            icon: Icons.upload,
                            onPressed: () async {
                              final mySettingMenuController = getIt<SettingMenuController>();
                              await mySettingMenuController.addMenuWithExcel(section);
                            },
                          ),
                        )
                      : null,
                  ?section.collectionAccess.updateCollectionWithExcel
                      ? Expanded(
                          child: MyButton(
                            label: "Excel",
                            icon: Icons.edit,
                            color: Colors.green,
                            onPressed: () async {
                              final mySettingMenuController = getIt<SettingMenuController>();
                              await mySettingMenuController.updateCollectionWithExcel(section);
                            },
                          ),
                        )
                      : null,
                  ?section.collectionAccess.add
                      ? Expanded(
                          child: MyButton(
                            icon: Icons.add,
                            label: "Add",
                            onPressed: () {
                              getIt<MenuSectionController>().addItem(section.schema, "New ${section.title.split(" ").last}", context.isDesktop);
                            },
                          ),
                        )
                      : null,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionItemWidget extends StatelessWidget {
  final SchemaNode schema;
  final MenuDescriptor? section;
  final String label;
  final dynamic data;

  const SectionItemWidget({super.key, required this.schema, required this.data, this.section, required this.label});

  @override
  Widget build(BuildContext context) {
    final level = label.split(".").length + 1;
    final bool isMainObject = level == 2;
    final String showingLabel = label.split(".").last;
    // log("level $level ${section?.fieldTitle} ${section?.collectionAccess.editDocument}");
    // log(jsonEncode(data));
    // log(label);
    // log(section.schema.kind.name);
    // log("----- ${schema.kind}  --> ${schema.title} ${schema.fieldName} +++${label}");

    switch (schema.kind) {
      case SchemaKind.object:
        // log("----- ${schema.fieldName}");

        final o = schema as ObjectSchema;
        final Map<String, dynamic> v = _toStringKeyMap(data);
        return MyExpansionTile(
          childrenPadding: EdgeInsets.symmetric(horizontal: 4.0 * level),
          title: Row(
            spacing: 8,
            children: [
              Expanded(child: Text(label.split(".").last)),
              Visibility(
                visible: isMainObject || section?.collectionAccess.duplicateDocument == true,
                child: DotButton(
                  icon: Icons.copy,
                  onPressed: () async {
                    await getIt<MenuSectionController>().duplicateDocument(section, data["_id"]);
                  },
                ),
              ),
              // Visibility(
              //   visible: isMainObject || section?.documentAccess.getDocumentAsExcel == true,
              //   child: DotButton(
              //     icon: Icons.download,
              //     onPressed: () async {
              //       await getIt<MenuSectionController>().getDocumentAsExcel(section, data["_id"]);
              //     },
              //   ),
              // ),
              // Visibility(
              //   visible: isMainObject || section?.documentAccess.updateDocumentWithExcel == true,
              //   child: DotButton(
              //     icon: Icons.upload,
              //     color: Colors.green,
              //     onPressed: () async {
              //       await getIt<MenuSectionController>().updateDocumentWithExcel(section, data["_id"]);
              //     },
              //   ),
              // ),
              Visibility(
                visible: isMainObject || section?.collectionAccess.editDocument == true,
                child: DotButton(
                  icon: Icons.edit,
                  onPressed: () {
                    getIt<MenuSectionController>().editItem(schema, data, showingLabel, context.isDesktop);
                  },
                ),
              ),
              // Visibility(
              //   visible: isMainObject || section?.documentAccess.delete == true,
              //   child: DotButton(
              //     icon: Icons.delete,
              //     color: Colors.red,
              //     onPressed: () async {
              //       await getIt<MenuSectionController>().deleteDocument(section, data["_id"]);
              //     },
              //   ),
              // ),
            ],
          ),
          showFooter: false,
          showTrailingIcon: true,
          children: o.properties.entries.map((entry) {
            final key = entry.key;
            final prop = entry.value;

            final nextPath = '$label.$key';
            final current = v[key] ?? emptyValueForSchema(prop.schema);
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SectionItemWidget(schema: prop.schema, data: current, label: nextPath),
            );
          }).toList(),
        );
      case SchemaKind.array:
        // log("----- array  --> ${schema.title} ${schema.fieldName}");

        final array = schema as ArraySchema;
        final List<dynamic> v = (data is List) ? data as List<dynamic> : <dynamic>[data];
        if (v.length == 1) {
          final internalPath = '$label[0]'; // stable
          final itemValue = v[0];
          final prettyLabel = (schema.fieldName == null || schema.fieldName!.isEmpty) ? 'label' : schema.fieldName!.map((a) => itemValue[a]).join(" ");

          return SectionItemWidget(schema: array.items, data: itemValue, label: prettyLabel);
        }
        return MyExpansionTile(
          initiallyExpanded: false,
          childrenPadding: EdgeInsets.symmetric(horizontal: 4.0 * level),
          title: Row(
            children: [
              Expanded(child: Text(label.split(".").last)),
              Visibility(
                visible: isMainObject && section?.documentAccess.edit != true,
                child: DotButton(
                  icon: Icons.edit,
                  onPressed: () {
                    getIt<MenuSectionController>().editItem(schema, data, showingLabel, context.isDesktop);
                  },
                ),
              ),
            ],
          ),
          showFooter: false,
          showTrailingIcon: true,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: v.length,
              itemBuilder: (_, index) {
                final internalPath = '$label[$index]'; // stable
                // final prettyLabel = '$label ${index + 1}';

                final itemValue = v[index];
                final prettyLabel = (schema.fieldName == null || schema.fieldName!.isEmpty) ? 'label' : schema.fieldName!.map((a) => itemValue[a]).join(" ");

                final itemKey = ValueKey(internalPath);
                final content = SectionItemWidget(schema: array.items, data: itemValue, label: prettyLabel);
                return content;
              },
            ),
          ],
        );
        return Column(children: [Text(label), Text("$v")]);
      case SchemaKind.string:
        final v = data is String ? data : '';
        final p = schema as PrimitiveSchema;
        final l = _labelFromPath(label);
        if (l == "_id") {
          return SizedBox();
        }
        return FieldDataWidget(label: l, data: v);

      case SchemaKind.number:
        final v = data is num ? data : 0;
        final p = schema as PrimitiveSchema;
        final l = _labelFromPath(label);
        return FieldDataWidget(label: l, data: v);
      case SchemaKind.boolean:
        final v = data is bool ? data : false;
        final p = schema as PrimitiveSchema;
        final l = _labelFromPath(label);
        return FieldDataWidget(label: l, data: v);

      default:
        return Container();
    }
    // return Container();
  }
}

class FieldDataWidget extends StatelessWidget {
  final String label;
  final dynamic data;

  const FieldDataWidget({super.key, required this.label, this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: MyTextFieldNew(
        headerBgColor: headerBgColor,
        bodyBgColor: bodyBgColor,
        rowLabelRatio: [4, 5],
        disabled: true,
        label: label,
        controller: TextEditingController.fromValue(TextEditingValue(text: "${data ?? ''}")),
      ),
    );
  }
}

Map<String, dynamic> _toStringKeyMap(dynamic v) {
  if (v is Map<String, dynamic>) return v;
  if (v is Map) {
    return v.map((k, val) => MapEntry(k.toString(), val));
  }
  return <String, dynamic>{};
}

String _labelFromPath(String path) {
  final dot = path.lastIndexOf('.');
  final br = path.lastIndexOf('[');
  final cut = dot > br ? dot : br;
  final raw = cut >= 0 ? path.substring(cut + 1) : path;
  return raw.replaceAll(RegExp(r'\[\d+\]'), '').split(".").last;
}
