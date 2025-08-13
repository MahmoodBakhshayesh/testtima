import 'dart:async';
import 'dart:math';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/widgets/MyTextField.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../core/constants/ui.dart';
import '../core/utils_and_services/pickers.dart';
import 'DotButton.dart';
import 'dart:developer' as dev;

class MyFieldPicker<T> extends StatefulWidget {
  final String Function(T)? itemToString;
  final Color Function(T)? itemToColor;
  final Widget Function(T)? itemToWidget;
  final List<T> items;
  final ValueChanged<T?>? onChange;
  final T? value;
  final String? label;
  final String? placeholder;
  final bool showClearButton;
  final bool supportNull;
  final bool locked;
  final bool hasSearch;
  final bool required;
  final bool labelInRow;
  final TextStyle? style;

  const MyFieldPicker({
    super.key,
    this.itemToString,
    this.locked = false,
    this.required = false,
    this.labelInRow = false,
    this.style,
    this.itemToColor,
    required this.label,
    this.placeholder,
    required this.items,
    this.onChange,
    this.hasSearch = true,
    this.value,
    this.showClearButton = true,
    this.supportNull = true,
    this.itemToWidget,
  });

  @override
  State<MyFieldPicker<T>> createState() => _MyFieldPickerState<T>();
}

class _MyFieldPickerState<T> extends State<MyFieldPicker<T>> {
  TextEditingController controller = TextEditingController();
  late ValueNotifier<T?> value = ValueNotifier<T?>(widget.value);

  @override
  void initState() {
    controller = TextEditingController(text: widget.value?.toString() ?? '');
    value.addListener(() {
      Future(() {
        controller.text = value.value?.toString() ?? '';
        widget.onChange?.call(value.value);
        setState(() {});
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    value.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MyFieldPicker<T> oldWidget) {
    if (widget.value != oldWidget.value && mounted) {
      controller.text = widget.value == null ? "" : widget.value.toString();
      value.value = widget.value;
      setState(() {});
    }
    // controller.dropDownValue =widget.value==null?null: DropDownValueModel(name: widget.value?.toString()??'', value: widget.value, builder: widget.builder);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ValueListenableBuilder<T?>(
      valueListenable: value,
      builder: (context, v, _) {
        return InkWell(
          onTap: () {
            dev.log("pick item");
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return Padding(
                  // This moves content above the keyboard
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: PickerSheetWidget(items: widget.items, label: widget.placeholder ?? widget.label ?? '', itemToWidget: widget.itemToWidget, hasSearch: widget.hasSearch),
                );
                return PickerSheetWidget(items: widget.items, label: widget.placeholder ?? widget.label ?? '', itemToWidget: widget.itemToWidget, hasSearch: widget.hasSearch);
              },
              elevation: 2,
            ).then((v) {
              if (v != null) {
                dev.log(v.toString());
                value.value = v;
                setState(() {});
              }
            });
          },
          child: AbsorbPointer(
            child: MyTextField(
              showError: false,
              required: widget.required,
              labelInRow: true,
              controller: controller,
              borderSide: BorderSide(color: Colors.white, width: 1),
              radius: BorderRadius.circular(8),
              label: widget.label,
              placeholder: widget.placeholder,
              suffixIcon: Icon(Icons.arrow_drop_down),
            ),
          ),
        );
      },
    );
  }
}

class PickerSheetWidget<T> extends StatefulWidget {
  final List<T> items;
  final String label;
  final bool hasSearch;
  final Widget Function(T)? itemToWidget;

  const PickerSheetWidget({super.key, required this.items, required this.label, this.itemToWidget, required this.hasSearch});

  @override
  State<PickerSheetWidget> createState() => _PickerSheetWidgetState();
}

class _PickerSheetWidgetState extends State<PickerSheetWidget> {
  TextEditingController searchC = TextEditingController();

  @override
  void initState() {
    searchC.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    searchC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.items.where((a) => searchC.text.isEmpty || a.toString().toLowerCase().contains(searchC.text.toLowerCase())).toList();
    items.sort((a, b) => a.toString().toLowerCase().indexOf(searchC.text.toLowerCase()).compareTo(b.toString().toLowerCase().indexOf(searchC.text.toLowerCase())));

    return SafeArea(
      child: BottomSheet(
        backgroundColor: Color(0xffEAECF2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        constraints: BoxConstraints(maxHeight: context.height*0.5),
        onClosing: () {},
        builder: (BuildContext context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12))
                ),
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text("Pick ${widget.label}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    CloseButton(),
                  ],
                ),
              ),
              // Divider(color: MyColors.black8,),
              widget.hasSearch
                  ? Container(
                      decoration: BoxDecoration(
                        // border: Border(bottom: BorderSide(color: MyColors.lineBorderColor)),
                      ),
                      child: CupertinoTextField(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        controller: searchC,
                        prefix: Padding(padding: const EdgeInsets.all(8.0), child: Icon(Icons.search)),
                      ),
                    )
                  : SizedBox(),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (c, i) {
                    final item = items[i];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pop(item);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffF2F3F6),
                          border: Border(bottom: BorderSide(color: Colors.white)),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                        child: Row(children: [Expanded(child: widget.itemToWidget?.call(item) ?? Text(item.toString()))]),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
