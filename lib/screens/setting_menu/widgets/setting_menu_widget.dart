// settings_menu_widgets_v2.dart
import 'dart:developer';

import 'package:abds/initialize.dart';
import 'package:abds/screens/setting_menu/setting_menu_controller.dart';
import 'package:abds/widgets/MyExpansionTile.dart';
import 'package:abds/widgets/MyTextFieldNew.dart';
import 'package:flutter/material.dart';

import '../../../core/classes/menu_class.dart';

/// A full screen that lists sections on the left and renders an editor on the right.
/// Keeps per-section form state in memory.
///
final headerBgColor = Colors.blue.withOpacity(0.3);
final bodyBgColor = Colors.blue.withOpacity(0.15);

class SettingsMenuScreen extends StatefulWidget {
  final SettingMenu menu;
  final Map<String, dynamic>? initialValuesByEndpoint;
  final Future<void> Function(MenuDescriptor section, dynamic data)? onSave;

  const SettingsMenuScreen({super.key, required this.menu, this.initialValuesByEndpoint, this.onSave});

  @override
  State<SettingsMenuScreen> createState() => _SettingsMenuScreenState();
}

class _SettingsMenuScreenState extends State<SettingsMenuScreen> {
  int _selected = 0;
  // late final Map<String, dynamic> _values; // endpoint -> data

  List<MenuDescriptor> get _sections => widget.menu.sections;

  @override
  void initState() {
    super.initState();
    // _values = {};
    // for (final s in _sections) {
    //   _values[s.endpoint] = widget.initialValuesByEndpoint?[s.endpoint] ?? newEmptyDataForSection(s);
    // }
  }

  @override
  Widget build(BuildContext context) {
    log(widget.initialValuesByEndpoint.toString());
    final section = _sections[_selected];

    // if(!(widget.initialValuesByEndpoint?.containsKey(section.endpoint)??true)){
    //   return SizedBox();
    // }
    var _values = widget.initialValuesByEndpoint??{};

    log("${_values[section.endpoint]}");
    log("${(_values[section.endpoint] as List).length}");


    return LayoutBuilder(
      builder: (context, c) {
        final isWide = c.maxWidth > 920;

        final nav = NavigationRail(
          selectedIndex: _selected,
          onDestinationSelected: (i) {
            getIt<SettingMenuController>().loadData(section);
            setState(() => _selected = i);
          },
          labelType: NavigationRailLabelType.all,
          destinations: [for (final s in _sections) NavigationRailDestination(icon: const Icon(Icons.settings_outlined), selectedIcon: const Icon(Icons.settings), label: Text(s.title))],
        );

        final editor = Padding(
          padding: const EdgeInsets.all(16),
          child: SettingsSectionEditorV2(
            section: section,
            initialValue: _values[section.endpoint],
            onChanged: (v) => _values[section.endpoint] = v,
            onSubmit: widget.onSave == null
                ? null
                : () async {
                    await widget.onSave!(section, _values[section.endpoint]);
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved')));
                  },
          ),
        );

        log(isWide.toString());
        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 280, child: nav),
              const VerticalDivider(width: 1),
              Expanded(child: editor),
            ],
          );
        } else {
          return Scaffold(
            drawer: Drawer(
              child: ListView(
                children: [
                  const DrawerHeader(child: Text('Settings')),
                  for (var i = 0; i < _sections.length; i++)
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: Text(_sections[i].title),
                      selected: i == _selected,
                      onTap: () {
                        setState(() => _selected = i);
                        Navigator.pop(context);
                      },
                    ),
                ],
              ),
            ),
            appBar: AppBar(title: Text(section.title)),
            body: editor,
          );
        }
      },
    );
  }
}

/// Section editor with enum dropdowns, inline errors, and array drag-reorder.
class SettingsSectionEditorV2 extends StatefulWidget {
  final MenuDescriptor section;
  final dynamic initialValue;
  final ValueChanged<dynamic>? onChanged;
  final EdgeInsetsGeometry padding;
  final String? saveButtonText;
  final VoidCallback? onSubmit;

  const SettingsSectionEditorV2({super.key, required this.section, this.initialValue, this.onChanged, this.padding = const EdgeInsets.all(0), this.saveButtonText, this.onSubmit});

  @override
  State<SettingsSectionEditorV2> createState() => _SettingsSectionEditorV2State();
}

class _SettingsSectionEditorV2State extends State<SettingsSectionEditorV2> {
  // late dynamic _value;
  late Map<String, List<String>> _errorIndex;

  @override
  void initState() {
    super.initState();
    // _value = widget.initialValue ?? newEmptyDataForSection(widget.section);
    WidgetsBinding.instance.addPostFrameCallback((_){
      var data = getIt<SettingMenuController>().loadData(widget.section);
    });
    _revalidate();
  }

  void _revalidate() {
    // final flat = validateAgainstSchema(widget.section.schema, _value);
    // _errorIndex = buildErrorIndex(flat);
  }

  void _updateValue(dynamic newValue) {
    // var others = widget.section.getOtherValue(_value);
    // var update = [...others, ...newValue];
    // setState(() {
    //   _value = update;
    //   _revalidate();
    // });
    // widget.onChanged?.call(update);
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.section.title;
    final endpoint = widget.section.endpoint;
    final hasErrors = _errorIndex.isNotEmpty;
    var _value = widget.initialValue;
    log(_value.toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _Header(title: title, subtitle: endpoint),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(onPressed: widget.onSubmit, icon: const Icon(Icons.save), label: Text("Load")),
            ),
            if (widget.onSubmit != null)
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(onPressed: widget.onSubmit, icon: const Icon(Icons.save), label: Text(widget.saveButtonText ?? 'Save')),
              ),
          ],
        ),
        const SizedBox(height: 12),
        if (hasErrors) _SummaryBanner(errors: _errorIndex),
        Expanded(
          child: SingleChildScrollView(child: SchemaNodeEditorV2(schema: widget.section.schema, value: widget.section.getValue(_value), onChanged: _updateValue, path: widget.section.title.split(" ").last, errorIndex: _errorIndex)),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

/// Dispatch editor with errors + required flag.
class SchemaNodeEditorV2 extends StatelessWidget {
  final SchemaNode schema;
  final dynamic value;
  final ValueChanged<dynamic> onChanged;
  final String path;
  final Map<String, List<String>> errorIndex;
  final bool requiredFlag; // from parent property, if applicable

  const SchemaNodeEditorV2({super.key, required this.schema, required this.value, required this.onChanged, required this.path, required this.errorIndex, this.requiredFlag = false});

  @override
  Widget build(BuildContext context) {
    // if(value != null){
    //   log("we have value for ${schema.kind}");
    // }
    switch (schema.kind) {
      case SchemaKind.object:
        return _ObjectEditorV2(schema: schema as ObjectSchema, value: (value is Map) ? value as Map<String, dynamic> : <String, dynamic>{}, onChanged: onChanged, path: path, errorIndex: errorIndex);
      case SchemaKind.array:
        return _ArrayEditorV2(schema: schema as ArraySchema, value: (value is List) ? value as List<dynamic> : <dynamic>[], onChanged: onChanged, path: path, errorIndex: errorIndex);
      case SchemaKind.string:
      case SchemaKind.number:
      case SchemaKind.boolean:
        final p = schema as PrimitiveSchema;
        final label = _labelFromPath(path);
        final errs = errorIndex[path] ?? const [];
        if (p.hasEnum) {
          return _EnumField(
            key: ValueKey(path),
            // ✅ stable per-field key
            label: label,
            value: value,
            onChanged: onChanged,
            enumValues: p.enumValues!,
            requiredFlag: requiredFlag,
            errors: errs,
            kind: schema.kind,
          );
        }
        // regular primitive fields
        switch (schema.kind) {
          case SchemaKind.string:
            return _StringFieldV2(
              key: ValueKey(path),
              // ✅ stable per-field key
              label: label,
              value: value is String ? value : '',
              onChanged: onChanged,
              requiredFlag: requiredFlag,
              errors: errs,
            );
          case SchemaKind.number:
            return _NumberFieldV2(
              key: ValueKey(path),
              // ✅ stable per-field key
              label: label,
              value: (value is num) ? value : 0,
              onChanged: (num v) => onChanged(v),
              requiredFlag: requiredFlag,
              errors: errs,
            );
          case SchemaKind.boolean:
            return _BoolFieldV2(
              key: ValueKey(path),
              // ✅ stable per-field key
              label: label,
              value: value is bool ? value : false,
              onChanged: (bool v) => onChanged(v),
              requiredFlag: requiredFlag,
              errors: errs,
            );
          default:
            return const SizedBox.shrink();
        }
    }
  }
}

/// ----- Object Editor (with required badges & inline errors on groups) -----
class _ObjectEditorV2 extends StatelessWidget {
  final ObjectSchema schema;
  final Map<String, dynamic> value;
  final ValueChanged<dynamic> onChanged;
  final String path;
  final Map<String, List<String>> errorIndex;

  const _ObjectEditorV2({required this.schema, required this.value, required this.onChanged, required this.path, required this.errorIndex});

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    int level = path.split(".").length;
    // log("level $level");
    if (level == 1) {
      return MyExpansionTile(
        title: Text(path),
        childrenPadding: EdgeInsets.symmetric(horizontal: 8),
        backgroundColor: Colors.greenAccent.withOpacity(0.12),
        collapsedBackgroundColor: Colors.greenAccent.withOpacity(0.12),
        showFooter: false,
        children: schema.properties
            .map((key, prop) {
              final nextPath = '$path.$key';
              final current = value[key] ?? emptyValueForSchema(prop.schema);
              final groupErrs = errorIndex[nextPath] ?? const [];

              return MapEntry(
                key,
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: SchemaNodeEditorV2(
                    schema: prop.schema,
                    value: current,
                    onChanged: (dynamic newChildValue) {
                      final updated = Map<String, dynamic>.from(value);
                      updated[key] = newChildValue;
                      onChanged(updated);
                    },
                    path: nextPath,
                    errorIndex: errorIndex,
                    requiredFlag: prop.required,
                  ),
                ),
              );
            })
            .values
            .toList(),
      );
    }
    if (schema.properties.length < 4) {
      return Row(
        spacing: 12,
        children: schema.properties
            .map((key, prop) {
              final nextPath = '$path.$key';
              final current = value[key] ?? emptyValueForSchema(prop.schema);
              final groupErrs = errorIndex[nextPath] ?? const [];
              // log("${key}  - ${nextPath}");

              return MapEntry(
                key,
                Expanded(
                  child: SchemaNodeEditorV2(
                    schema: prop.schema,
                    value: current,
                    onChanged: (dynamic newChildValue) {
                      final updated = Map<String, dynamic>.from(value);
                      updated[key] = newChildValue;
                      onChanged(updated);
                    },
                    path: nextPath,
                    errorIndex: errorIndex,
                    requiredFlag: prop.required,
                  ),
                ),
              );
            })
            .values
            .toList(),
      );
    }
    return Column(
      spacing: 8,
      children: schema.properties
          .map((key, prop) {
            final nextPath = '$path.$key';
            final current = value[key] ?? emptyValueForSchema(prop.schema);
            final groupErrs = errorIndex[nextPath] ?? const [];
            // log("${key}  - ${nextPath}");

            return MapEntry(
              key,
              SchemaNodeEditorV2(
                schema: prop.schema,
                value: current,
                onChanged: (dynamic newChildValue) {
                  final updated = Map<String, dynamic>.from(value);
                  updated[key] = newChildValue;
                  onChanged(updated);
                },
                path: nextPath,
                errorIndex: errorIndex,
                requiredFlag: prop.required,
              ),
            );
          })
          .values
          .toList(),
    );

    schema.properties.forEach((key, prop) {
      final nextPath = '$path.$key';
      final current = value[key] ?? emptyValueForSchema(prop.schema);
      final groupErrs = errorIndex[nextPath] ?? const [];
      log(nextPath);
      children.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (prop.schema is! PrimitiveSchema)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6, left: 2),
                  child: Row(
                    children: [
                      Text(_humanizeLabel(key), style: Theme.of(context).textTheme.titleMedium),
                      if (prop.required)
                        const Padding(
                          padding: EdgeInsets.only(left: 6),
                          child: Text('*', style: TextStyle(color: Colors.red)),
                        ),
                    ],
                  ),
                ),
              SchemaNodeEditorV2(
                schema: prop.schema,
                value: current,
                onChanged: (dynamic newChildValue) {
                  final updated = Map<String, dynamic>.from(value);
                  updated[key] = newChildValue;
                  onChanged(updated);
                },
                path: nextPath,
                errorIndex: errorIndex,
                requiredFlag: prop.required,
              ),
              if (groupErrs.isNotEmpty) _InlineError(groupErrs),
            ],
          ),
        ),
      );
    });

    // if(children.length<3){
    //   return Row(children: children);
    // }
    return Column(children: children);
  }
}

/// ----- Array Editor with Reorderable + stable keys to preserve focus -----
class _ArrayEditorV2 extends StatelessWidget {
  final ArraySchema schema;
  final List<dynamic> value;
  final ValueChanged<dynamic> onChanged;
  final String path;
  final Map<String, List<String>> errorIndex;

  const _ArrayEditorV2({required this.schema, required this.value, required this.onChanged, required this.path, required this.errorIndex});

  bool get _itemsArePrimitives => schema.items is PrimitiveSchema;

  @override
  Widget build(BuildContext context) {
    final title = _labelFromPath(path);
    final header = title.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 2, top: 4),
            child: Text(title, style: Theme.of(context).textTheme.titleMedium),
          )
        : const SizedBox.shrink();

    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.25),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header,
            ReorderableListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.length,
              buildDefaultDragHandles: false,
              onReorder: (oldIndex, newIndex) {
                if (newIndex > oldIndex) newIndex -= 1;
                final updated = List<dynamic>.from(value);
                final item = updated.removeAt(oldIndex);
                updated.insert(newIndex, item);
                onChanged(updated);
              },
              itemBuilder: (_, index) {
                // final itemPath = '$path[$index]';
                final itemPath = '${path} ${index + 1}';
                final itemValue = value[index];

                // ✅ Stable key that does NOT depend on the item value
                // (prevents losing focus while typing)
                final itemKey = ValueKey(itemPath);

                final content = SchemaNodeEditorV2(
                  schema: schema.items,
                  value: itemValue,
                  onChanged: (dynamic v) {
                    final updated = List<dynamic>.from(value);
                    updated[index] = v;
                    onChanged(updated);
                  },
                  path: itemPath,
                  errorIndex: errorIndex,
                );

                final child = Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: content),
                    Row(
                      children: [
                        ReorderableDragStartListener(index: index, child: Icon(Icons.drag_indicator)),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () {
                            final updated = List<dynamic>.from(value)..removeAt(index);
                            onChanged(updated);
                          },
                        ),
                      ],
                    ),
                  ],
                );

                return Padding(key: itemKey, padding: const EdgeInsets.only(bottom: 12), child: child);
              },
            ),
            Row(
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    final updated = List<dynamic>.from(value)..add(emptyValueForSchema(schema.items));
                    onChanged(updated);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add item'),
                ),
                const SizedBox(width: 8),
                if (value.length >= 2)
                  OutlinedButton.icon(
                    onPressed: () {
                      final updated = List<dynamic>.from(value.reversed);
                      onChanged(updated);
                    },
                    icon: const Icon(Icons.swap_vert),
                    label: const Text('Reverse'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// ----- Primitive: String (with stable key support) -----
class _StringFieldV2 extends StatefulWidget {
  final String label;
  final String value;
  final ValueChanged<String> onChanged;
  final bool requiredFlag;
  final List<String> errors;

  const _StringFieldV2({
    super.key, // ✅ allow passing a ValueKey(path)
    required this.label,
    required this.value,
    required this.onChanged,
    required this.requiredFlag,
    required this.errors,
  });

  @override
  State<_StringFieldV2> createState() => _StringFieldV2State();
}

class _StringFieldV2State extends State<_StringFieldV2> {
  late final TextEditingController _c;

  @override
  void initState() {
    super.initState();
    _c = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(covariant _StringFieldV2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value && _c.text != widget.value) {
      _c.text = widget.value;
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final label = widget.requiredFlag ? '${_humanizeLabel(widget.label)} *' : _humanizeLabel(widget.label);
    return MyTextFieldNew(headerBgColor: headerBgColor, bodyBgColor: bodyBgColor, controller: _c, label: label.isEmpty ? null : label, onChanged: widget.onChanged);
    return TextField(
      controller: _c,
      decoration: InputDecoration(labelText: label.isEmpty ? null : label, border: const OutlineInputBorder(), isDense: true, errorText: widget.errors.isNotEmpty ? widget.errors.join('\n') : null),
      onChanged: widget.onChanged,
    );
  }
}

/// ----- Primitive: Number (with stable key support) -----
class _NumberFieldV2 extends StatefulWidget {
  final String label;
  final num value;
  final ValueChanged<num> onChanged;
  final bool requiredFlag;
  final List<String> errors;

  const _NumberFieldV2({
    super.key, // ✅ allow passing a ValueKey(path)
    required this.label,
    required this.value,
    required this.onChanged,
    required this.requiredFlag,
    required this.errors,
  });

  @override
  State<_NumberFieldV2> createState() => _NumberFieldV2State();
}

class _NumberFieldV2State extends State<_NumberFieldV2> {
  late final TextEditingController _c;

  @override
  void initState() {
    super.initState();
    _c = TextEditingController(text: widget.value.toString());
  }

  @override
  void didUpdateWidget(covariant _NumberFieldV2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newText = widget.value.toString();
    if (oldWidget.value != widget.value && _c.text != newText) {
      _c.text = newText;
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final label = widget.requiredFlag ? '${_humanizeLabel(widget.label)} *' : _humanizeLabel(widget.label);
    return MyTextFieldNew(
      headerBgColor: headerBgColor,
      bodyBgColor: bodyBgColor,
      label: label.isEmpty ? null : label,
      controller: _c,
      keyboardType: TextInputType.number,
      onChanged: (s) {
        final parsed = num.tryParse(s);
        if (parsed != null) widget.onChanged(parsed);
      },
    );
    return TextField(
      controller: _c,
      decoration: InputDecoration(labelText: label.isEmpty ? null : label, border: const OutlineInputBorder(), isDense: true, errorText: widget.errors.isNotEmpty ? widget.errors.join('\n') : null),
      keyboardType: TextInputType.number,
      onChanged: (s) {
        final parsed = num.tryParse(s);
        if (parsed != null) widget.onChanged(parsed);
      },
    );
  }
}

/// ----- Primitive: Boolean (with stable key support) -----
class _BoolFieldV2 extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool requiredFlag;
  final List<String> errors;

  const _BoolFieldV2({
    super.key, // ✅ allow passing a ValueKey(path)
    required this.label,
    required this.value,
    required this.onChanged,
    required this.requiredFlag,
    required this.errors,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          dense: true,
          title: Row(
            children: [
              Text(_humanizeLabel(label)),
              if (requiredFlag)
                const Padding(
                  padding: EdgeInsets.only(left: 6),
                  child: Text('*', style: TextStyle(color: Colors.red)),
                ),
            ],
          ),
          value: value,
          onChanged: (v) => onChanged(v ?? false),
          controlAffinity: ListTileControlAffinity.leading,
        ),
        if (errors.isNotEmpty) Align(alignment: Alignment.centerLeft, child: _InlineError(errors)),
      ],
    );
  }
}

/// ----- Enum dropdown (with stable key support) -----
class _EnumField extends StatelessWidget {
  final String label;
  final dynamic value; // selected value (single)
  final ValueChanged<dynamic> onChanged;
  final List<dynamic> enumValues; // the whole list
  final bool requiredFlag;
  final List<String> errors;
  final SchemaKind kind;

  const _EnumField({
    super.key, // ✅ allow passing a ValueKey(path)
    required this.label,
    required this.value,
    required this.onChanged,
    required this.enumValues,
    required this.requiredFlag,
    required this.errors,
    required this.kind,
  });

  @override
  Widget build(BuildContext context) {
    final labelText = requiredFlag ? '${_humanizeLabel(label)} *' : _humanizeLabel(label);

    return DropdownButtonFormField<dynamic>(
      value: enumValues.contains(value) ? value : null,
      decoration: InputDecoration(labelText: labelText.isEmpty ? null : labelText, border: const OutlineInputBorder(), isDense: true, errorText: errors.isNotEmpty ? errors.join('\n') : null),
      items: [for (final v in enumValues) DropdownMenuItem<dynamic>(value: v, child: Text(_enumLabel(v)))],
      onChanged: (v) {
        if (v == null) return;
        switch (kind) {
          case SchemaKind.number:
            if (v is num) onChanged(v);
            break;
          case SchemaKind.boolean:
            if (v is bool) onChanged(v);
            break;
          case SchemaKind.string:
            onChanged(v.toString());
            break;
          default:
            onChanged(v);
        }
      },
    );
  }
}

/// ----- Banners / helpers -----

class _Header extends StatelessWidget {
  final String title;
  final String subtitle;

  const _Header({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.headlineSmall),
        const SizedBox(height: 4),
        Text(subtitle, style: theme.bodySmall?.copyWith(color: Colors.grey[600])),
      ],
    );
  }
}

class _InlineError extends StatelessWidget {
  final List<String> errors;

  const _InlineError(this.errors);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, left: 4),
      child: Text(errors.join('\n'), style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12)),
    );
  }
}

class _SummaryBanner extends StatelessWidget {
  final Map<String, List<String>> errors;

  const _SummaryBanner({required this.errors});

  @override
  Widget build(BuildContext context) {
    final flat = errors.entries.expand((e) => e.value.map((m) => '${e.key}: $m')).toList();

    return Card(
      color: Theme.of(context).colorScheme.errorContainer.withOpacity(.22),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyMedium!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Validation', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              ...flat.map(
                (e) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• '),
                    Expanded(child: Text(e)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _labelFromPath(String path) {
  final dot = path.lastIndexOf('.');
  final br = path.lastIndexOf('[');
  final cut = dot > br ? dot : br;
  final raw = cut >= 0 ? path.substring(cut + 1) : path;
  return raw.replaceAll(RegExp(r'\[\d+\]'), '');
}

String _humanizeLabel(String s) {
  if (s == r'$' || s.isEmpty) return '';
  final spaced = s.replaceAllMapped(RegExp(r'([a-z0-9])([A-Z])'), (m) => '${m[1]} ${m[2]}').replaceAll('_', ' ');
  return '${spaced[0].toUpperCase()}${spaced.substring(1)}';
}

String _enumLabel(dynamic v) {
  if (v is String) return v;
  if (v is bool) return v ? 'True' : 'False';
  return v.toString();
}
