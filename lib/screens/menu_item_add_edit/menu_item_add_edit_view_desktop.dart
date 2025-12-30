import 'dart:convert';
import 'dart:developer';
import 'package:abds/core/interfaces/failures_int.dart';
import 'package:abds/core/utils_and_services/handlers/failure_handler.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:abds/widgets/MyFieldPicker.dart';
import 'package:abds/widgets/MySwitchButton.dart';
import 'package:abds/widgets/MyTextField.dart';
import 'package:artemis_acps/widgets/general_buttom.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:super_tooltip/super_tooltip.dart';
import '../../core/classes/menu_class.dart';
import '../../widgets/DotButton.dart';
import '../../widgets/MyExpansionTile.dart';
import '../../widgets/MyTextFieldNew.dart';
import '../menu_item_add_edit/menu_item_add_edit_controller.dart';
import '../menu_item_add_edit/menu_item_add_edit_state.dart';
import '../menu_section/menu_section_controller.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';
import '../menu_section/menu_section_state.dart';

final headerBgColor = Colors.blue.withOpacity(0.3);
final bodyBgColor = Colors.blue.withOpacity(0.15);

class MenuItemAddEditViewDesktop extends ConsumerStatefulWidget {
  const MenuItemAddEditViewDesktop({super.key});

  @override
  ConsumerState<MenuItemAddEditViewDesktop> createState() => _MenuItemAddEditViewDesktopState();
}

class _MenuItemAddEditViewDesktopState extends ConsumerState<MenuItemAddEditViewDesktop> {
  static MenuItemAddEditController myMenuItemAddEditController = getIt<MenuItemAddEditController>();
  dynamic changed;

  onSubmit(SchemaNode schema) async {
    final errors = validateAgainstSchema(ref.watch(editingSchemaProvider)!, changed);
    if (errors.isNotEmpty) {
      FailureHandler.handle(ValidationFailure(code: -1, msg: errors.join("\n"), traceMsg: errors.join("\n")));
      return;
    }
    log(changed.runtimeType.toString());
    if (changed is Map) {
      log("changed is Map and ${(changed as Map).containsKey("_id")}");
      if ((changed as Map).containsKey("_id") && (changed as Map)["_id"].toString().isNotEmpty) {
        await myMenuItemAddEditController.saveItem(schema, changed, context.isDesktop);
      } else {
        await myMenuItemAddEditController.addItem(schema, changed, context.isDesktop);
      }
    } else if (changed is List) {
      log("changed is list Map and ${(changed[0] as Map).containsKey("_id")}");

      if ((changed[0] as Map).containsKey("_id") && (changed[0] as Map)["_id"].toString().isNotEmpty) {
        await myMenuItemAddEditController.saveItem(schema, changed, context.isDesktop);
      } else {
        await myMenuItemAddEditController.addItem(schema, changed, context.isDesktop);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final editing = Map<String, dynamic>.from(ref.watch(editingMenuProvider) ?? {});
    final editingSchema = ref.watch(editingSchemaProvider);
    final editingLabel = ref.watch(editingLabelProvider);
    return EditingItemWidgetDesktop(
      isRoot: true,

      onChange: (up) {
        changed = up;
        setState(() {});
      },
      onSubmit: () async =>await onSubmit(editingSchema),
      schema: editingSchema!,
      data: editing,
      label: editingLabel!,
    );
  }
}

class MenuItemAddEditAppBarDesktop extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final String? id;
  final VoidCallback onSubmit;
  static MenuItemAddEditController myMenuItemAddEditController = getIt<MenuItemAddEditController>();

  const MenuItemAddEditAppBarDesktop({super.key, required this.title, required this.onSubmit, this.id});

  @override
  Size get preferredSize => const Size.fromHeight(108);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final section = ref.watch(menuSectionProvider);

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
                      Text("${section}", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                      Spacer(),
                      Visibility(
                        visible: section?.documentAccess.getDocumentAsExcel == true && id !=null,
                        child: DotButton(
                          size: 40,
                          icon: Icons.download,
                          onPressed: () async {
                            await getIt<MenuSectionController>().getDocumentAsExcel(section,id!);
                          },
                        ),
                      ),
                      Visibility(
                        visible: section?.documentAccess.updateDocumentWithExcel == true && id!=null,
                        child: DotButton(
                          size: 40,
                          icon: Icons.upload,
                          color: Colors.green,
                          onPressed: () async {
                            await getIt<MenuSectionController>().updateDocumentWithExcel(section, id!);
                          },
                        ),
                      ),
                      Visibility(
                        visible:  section?.documentAccess.delete == true && id!=null,
                        child: DotButton(
                          size: 40,
                          icon: Icons.delete,
                          color: Colors.red,
                          onPressed: () async {
                            await getIt<MenuSectionController>().deleteDocument(section, id!);
                          },
                        ),
                      ),
                      MyButton(label: "Save", onPressed: onSubmit),
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

class EditingItemWidgetDesktop extends StatefulWidget {
  final SchemaNode schema;
  final String label;
  final bool isRoot;
  final dynamic data;
  final VoidCallback? onAdd;
  final VoidCallback? onDelete;
  final VoidCallback? onSubmit;
  final void Function(dynamic)? onChange;

  const EditingItemWidgetDesktop({super.key, required this.schema, required this.data, this.isRoot = false, required this.label, this.onAdd, this.onDelete, this.onChange, this.onSubmit});

  @override
  State<EditingItemWidgetDesktop> createState() => _EditingItemWidgetDesktopState();
}

class _EditingItemWidgetDesktopState extends State<EditingItemWidgetDesktop> {
  late var tmp = widget.data;
  TextEditingController editingController = TextEditingController();
  final _toolTipController = SuperTooltipController();

  @override
  void initState() {
    if ([SchemaKind.string, SchemaKind.number].contains(widget.schema.kind)) {
      // log("setting textC = ${widget.data?.toString() ?? ""}");
      editingController.text = widget.data?.toString() ?? "";
      editingController.addListener(() {
        tmp = editingController.text;
        if (widget.schema.kind == SchemaKind.number) {
          widget.onChange?.call(int.tryParse(tmp) ?? 0);
        } else {
          widget.onChange?.call(tmp);
        }
        setState(() {});
      });
    } else {
      // log("${widget.schema.kind} no textfi");
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onChange?.call(tmp);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final level = widget.label.split(".").length + 1;
    final bool isMainObject = level == 2;
    final String showingLabel = widget.schema.title ?? widget.label.split(".").last;
    // log("${showingLabel} -- >${widget.schema.kind}");
    switch (widget.schema.kind) {
      case SchemaKind.object:
        final o = widget.schema as ObjectSchema;
        // final String showingLabel = widget.label.split(".").last;
        final Map<String, dynamic> v = _toStringKeyMap(tmp);
        if(widget.isRoot){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(child: Text(showingLabel)),
                      // ?widget.onDelete != null ? DotButton(icon: Icons.delete, onPressed: widget.onDelete!, color: Colors.red) : null,
                      Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
                        final section = ref.watch(menuSectionProvider);
                        final String? id = tmp["_id"];
                        return Row(
                          spacing: 8,
                          children: [
                          Visibility(
                            visible: section?.documentAccess.getDocumentAsExcel == true && id !=null,
                            child: DotButton(
                              size: 40,
                              icon: Icons.download,
                              onPressed: () async {
                                await getIt<MenuSectionController>().getDocumentAsExcel(section,id!);
                              },
                            ),
                          ),
                          Visibility(
                            visible: section?.documentAccess.updateDocumentWithExcel == true && id!=null,
                            child: DotButton(
                              size: 40,
                              icon: Icons.upload,
                              color: Colors.green,
                              onPressed: () async {
                                await getIt<MenuSectionController>().updateDocumentWithExcel(section, id!);
                              },
                            ),
                          ),
                          Visibility(
                            visible:  section?.documentAccess.delete == true && id!=null,
                            child: DotButton(
                              size: 40,
                              icon: Icons.delete,
                              color: Colors.red,
                              onPressed: () async {
                                await getIt<MenuSectionController>().deleteDocument(section, id!);
                              },
                            ),
                          ),
                        ],);
                      },),
                      const SizedBox(width: 8),
                      MyButton(label: "Save",onPressed: widget.onSubmit,)
                    ],
                  ),
                ),
                Expanded(child: SingleChildScrollView(child: Column(children: o.properties.entries.map((entry) {
                  final key = entry.key;
                  final prop = entry.value;
                  final nextPath = '${widget.label}.$key';
                  final current = v[key] ?? emptyValueForSchema(prop.schema);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: EditingItemWidgetDesktop(
                      schema: prop.schema,
                      data: current,
                      label: nextPath,
                      onChange: (up) {
                        v[key] = up;
                        tmp = v;
                        widget.onChange?.call(tmp);
                      },
                    ),
                  );
                }).toList(),),))
              ],
            ),
          );
        }

        return MyExpansionTile(
          initiallyExpanded: true,
          showTrailingIcon: true,
          childrenPadding: EdgeInsets.symmetric(horizontal: 1.0 * level + (widget.isRoot?12:0)),
          title: Row(
            children: [
              Expanded(child: Text(showingLabel)),
              ?widget.onDelete != null ? DotButton(icon: Icons.delete, onPressed: widget.onDelete!, color: Colors.red) : null,
            ],
          ),
          showFooter: false,
          children: o.properties.entries.map((entry) {
            final key = entry.key;
            final prop = entry.value;
            final nextPath = '${widget.label}.$key';
            final current = v[key] ?? emptyValueForSchema(prop.schema);
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: EditingItemWidgetDesktop(
                schema: prop.schema,
                data: current,
                label: nextPath,
                onChange: (up) {
                  v[key] = up;
                  tmp = v;
                  widget.onChange?.call(tmp);
                },
              ),
            );
          }).toList(),
        );
      case SchemaKind.array:
        final array = widget.schema as ArraySchema;
        final List<dynamic> v = ((tmp is List) ? tmp as List<dynamic> : <dynamic>[tmp]);
        // if(showingLabel == "airportAirline") {
        //   log(jsonEncode(v));
        // }
        // if (v.length == 1) {
        //   final internalPath = '${widget.label}[0]'; // stable
        //   final prettyLabel = '${widget.label}';
        //   final itemValue = v[0];
        //   return EditingItemWidget(schema: array.items, data: itemValue, label: prettyLabel);
        // }
        // String showingLabel = widget.label.split(".").last;
        return MyExpansionTile(
          initiallyExpanded: true,
          enabled: false,
          childrenPadding: EdgeInsets.symmetric(horizontal: 1.0 * level),
          title: Row(
            children: [
              Expanded(child: Text(showingLabel)),
              DotButton(
                icon: Icons.add,
                onPressed: () {
                  final schema = widget.schema as ArraySchema;
                  final newItem = emptyValueForSchema(schema.items);
                  // log("new item ${newItem} ${schema}");
                  // final updated = List<dynamic>.from(tmp)..insert(0,deepClone(newItem));
                  final updated = List<dynamic>.from(tmp)..add(deepClone(newItem));
                  tmp = updated;
                  widget.onChange?.call(tmp);
                  setState(() {});


                  // final schema = widget.schema as ArraySchema;
                  // final newItem = emptyValueForSchema(schema.items);
                  // // log("new item ${newItem} ${schema}");
                  // final updated = List<dynamic>.from([deepClone(newItem),...tmp]);
                  // if(tmp is List){
                  //   (tmp as List).insert(0, deepClone(newItem));
                  // }
                  //
                  // widget.onChange?.call(tmp);
                  // setState(() {});
                },
              ),
            ],
          ),
          showFooter: false,
          children: [
            ListView.builder(
              shrinkWrap: true,
              reverse: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: v.length,
              itemBuilder: (_, index) {
                final internalPath = '${widget.label}[$index]'; // stable
                final prettyLabel = '${widget.label} ${index + 1}';
                final itemValue = v[index];
                final itemKey = ValueKey(internalPath);
                // log("item value = > of $prettyLabel ${itemValue}");
                final content = EditingItemWidgetDesktop(
                  key: Key("${showingLabel}-${index}"),
                  onDelete: () {
                    v.removeAt(index);
                    setState(() {});
                  },
                  schema: array.items,
                  onChange: (up) {
                    v[index] = up;
                    tmp = v;
                    widget.onChange?.call(tmp);
                  },
                  data: itemValue,
                  label: prettyLabel,
                );
                return content;
              },
            ),
          ],
        );
        return Column(children: [Text(widget.label), Text("$v")]);
      case SchemaKind.string:
      case SchemaKind.number:
      case SchemaKind.boolean:
        final v = tmp is String ? tmp : '';
        final p = widget.schema as PrimitiveSchema;
        final l = widget.schema.title ?? _labelFromPath(widget.label);

        if (l == "_id" || l == "ID") {
          return SizedBox();
        }
        if (p.hasEnum) {
          return Row(
            spacing: 8,
            children: [
              Expanded(
                child: MyFieldPicker(
                  headerBgColor: headerBgColor,
                  bodyBgColor: bodyBgColor,
                  rowLabelRatio: [4, 5],
                  items: p.enumValues!,
                  label: l,
                  value: v,
                  onChange: (a) {
                    tmp = a;
                    widget.onChange?.call(tmp);
                    setState(() {});
                  },
                ),
              ),
              ?widget.onDelete != null ? DotButton(icon: Icons.delete, onPressed: widget.onDelete!, color: Colors.red) : null,
              ?widget.schema.desc != null
                  ? SuperTooltip(
                showBarrier: true,
                controller: _toolTipController,
                content: Text("${widget.schema.desc}", softWrap: true, style: TextStyle(color: Colors.black)),
                child: DotButton(
                  icon: Icons.info,
                  onPressed: () {
                    _toolTipController.showTooltip();
                  },
                  color: Colors.black,
                ),
              )
                  : null,
            ],
          );
        }
        if (widget.schema.kind == SchemaKind.boolean) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              spacing: 8,
              children: [
                Expanded(
                  child: MySwitchButton(
                    headerBgColor: headerBgColor,
                    bodyBgColor: bodyBgColor,
                    rowLabelRatio: [4, 5],
                    value: tmp,
                    onChanged: (a) {
                      tmp = a;
                      widget.onChange?.call(tmp);
                      setState(() {});
                    },
                    label: showingLabel,
                  ),
                ),
                ?widget.onDelete != null ? DotButton(icon: Icons.delete, onPressed: widget.onDelete!, color: Colors.red) : null,
                ?widget.schema.desc != null ? DotButton(icon: Icons.info, onPressed: () {}, color: Colors.black) : null,
              ],
            ),
          );
        }

        bool isNumber = widget.schema.kind == SchemaKind.number;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            spacing: 8,
            children: [
              Expanded(
                child: MyTextFieldNew(
                  headerBgColor: headerBgColor,
                  bodyBgColor: bodyBgColor,
                  rowLabelRatio: [4, 5],
                  label: l,
                  inputFormatters: isNumber ? [MyInputFormatter.justNumber] : [],
                  keyboardType: isNumber ? TextInputType.numberWithOptions(signed: true) : null,
                  controller: editingController,
                ),
              ),
              ?widget.onDelete != null ? DotButton(icon: Icons.delete, onPressed: widget.onDelete!, color: Colors.red) : null,
              ?widget.schema.desc != null ? DotButton(icon: Icons.info, onPressed: () {}, color: Colors.black) : null,
            ],
          ),
        );
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
