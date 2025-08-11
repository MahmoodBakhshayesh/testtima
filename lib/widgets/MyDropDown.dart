import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../core/constants/ui.dart';
import '../core/utils_and_services/dropdown/dropdown_textfield.dart';

class MyDropDown<T> extends StatefulWidget {
  final String? label;
  final String? placeholder;
  final List<T> items;
  final T? value;
  final Widget Function(dynamic t)? builder;
  final Function onChange;
  final double? height;
  final bool hasSearch;
  final bool hasClear;
  final bool locked;
  final bool autoFocus;
  final bool required;
  final bool hasBorder;

  const MyDropDown({
    super.key,
    this.label,
    this.placeholder,
    this.value,
    this.height = 45,
    this.builder,
    this.hasSearch = true,
    this.hasClear = true,
    this.locked = false,
    this.required = false,
    this.autoFocus = false,
    this.hasBorder = false,
    required this.onChange,
    this.items = const [],
  });

  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  SingleValueDropDownController controller = SingleValueDropDownController();

  @override
  void initState() {
    controller.dropDownValue = widget.value == null ? null : DropDownValueModel(name: widget.value?.toString() ?? '', value: widget.value, builder: widget.builder ?? defaultBuilder);
    controller.addListener(() {
      controller.dropDownValue = controller.dropDownValue;
      setState(() {});
    });

    super.initState();
  }

  @override
  void didUpdateWidget(covariant MyDropDown oldWidget) {
    if (widget.value != oldWidget.value) {
      controller.dropDownValue = widget.value == null ? null : DropDownValueModel(name: widget.value?.toString() ?? '', value: widget.value, builder: widget.builder ?? defaultBuilder);
    }
    // controller.dropDownValue =widget.value==null?null: DropDownValueModel(name: widget.value?.toString()??'', value: widget.value, builder: widget.builder);
    super.didUpdateWidget(oldWidget);
  }

  final defaultBuilder = (a) => Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12)),borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(8.0),
        child: Text("$a"),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label == null
            ? SizedBox()
            : Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Text(
                      widget.label ?? '',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: MyColors.black2),
                    ),
                    const SizedBox(width: 4),
                    widget.required?Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: const Icon(Icons.star_rate_rounded,color: Colors.black,size: 8,),
                    ):const SizedBox()
                  ],
                ),
              ),
        SizedBox(
          height: widget.height,
          child: DropDownTextField(

            isEnabled: !widget.locked && widget.items.isNotEmpty,
            textStyle: TextStyle(height: 1, fontSize: 13),
            
            padding: EdgeInsets.zero,
            controller: controller,
            dropDownItemCount: 2,
            searchAutofocus: widget.autoFocus,
            clearOption: widget.hasClear,

            dropDownIconProperty: IconProperty(
              icon: Icons.keyboard_arrow_down_sharp,
            ),
            dropdownRadius: 4,
            onChanged: (a) {
              if (a is String) {
                controller.dropDownValue = DropDownValueModel(name: a, value: widget.items.firstWhereOrNull((e) => e.toString() == a), builder: widget.builder ?? defaultBuilder);
                widget.onChange(null);
              } else {
                controller.dropDownValue = DropDownValueModel(name: (a as DropDownValueModel).name, value: widget.items.firstWhereOrNull((e) => e.toString() == a), builder: widget.builder ?? defaultBuilder);
                widget.onChange((a).value);
              }

              // print("setting value ${a.runtimeType} ${a}");
              setState(() {});
            },
            enableSearch: widget.hasSearch,
            searchDecoration: const InputDecoration(
              hintText: "Search",
              prefixIcon: Icon(
                Icons.search,
                color: Color(0xffb9b9b9),
              ),
              hintStyle: TextStyle(
                color: Color(0xffb9b9b9),
                fontWeight: FontWeight.w400,
              ),
            ),
            textFieldDecoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: widget.items.isEmpty ? "No Item Available" : widget.placeholder,
              hintStyle: const TextStyle(
                color: Color(0xffb9b9b9),
                fontWeight: FontWeight.w400,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red
                )
              )
              // border: OutlineInputBorder(borderSide: widget.hasBorder ? BorderSide(color: Colors.red.withOpacity(0.12)) : BorderSide(color: Colors.black.withOpacity(0.12))),
              // enabledBorder: OutlineInputBorder(borderSide: widget.hasBorder ? BorderSide(color: Colors.red.withOpacity(0.012)) : BorderSide(color: Colors.black.withOpacity(0.012))),
              // focusedBorder: OutlineInputBorder(borderSide: widget.hasBorder ? BorderSide(color: Colors.red.withOpacity(0.012)) : BorderSide(color: Colors.black.withOpacity(0.012))),
              // disabledBorder: OutlineInputBorder(borderSide: widget.hasBorder ? BorderSide(color: Colors.red.withOpacity(0.012)) : BorderSide(color: Colors.black.withOpacity(0.012))),
              // enabledBorder: OutlineInputBorder(borderSide: widget.hasBorder || true? BorderSide(color: Colors.red.withOpacity(0.012)) : BorderSide.none),
              // focusedBorder: OutlineInputBorder(borderSide: widget.hasBorder || true? BorderSide(color: Colors.red.withOpacity(0.012)) : BorderSide.none),
              // disabledBorder: OutlineInputBorder(borderSide: widget.hasBorder || true? BorderSide(color: Colors.red.withOpacity(0.012)) : BorderSide.none),

            ),
            clearIconProperty: widget.locked ? IconProperty(icon: Icons.lock) : null,
            dropDownList: widget.items.map((e) => DropDownValueModel(name: e.toString(), value: e, builder: widget.builder ?? defaultBuilder)).toList(),
          ),
        ),
      ],
    );
  }
}
