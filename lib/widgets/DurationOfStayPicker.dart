import 'package:abds/widgets/MyTextField.dart';
import 'package:artemis_ui_kit/artemis_ui_kit.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import '../core/utils_and_services/timatic/artemis_timatic.dart';
import 'MyButton.dart';


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

import 'MyTextFieldNew.dart';

class MyDurationOfStayPicker extends StatefulWidget {
  final ValueChanged<DurationOfStay?>? onChange;
  final DurationOfStay? value;
  final String? label;
  final String? placeholder;
  final bool showClearButton;
  final bool supportNull;
  final bool locked;
  final bool hasSearch;
  final bool required;
  final bool labelInRow;
  final Color? headerBgColor;
  final Color? bodyBgColor;
  final TextStyle? style;
  final List<int>  rowLabelRatio;

  const MyDurationOfStayPicker({
    super.key,
    this.locked = false,
    this.rowLabelRatio = const[12,33],
    this.required = false,
    this.labelInRow = false,
    this.style,
    this.headerBgColor,
    this.bodyBgColor,
    required this.label,
    this.placeholder,
    this.onChange,
    this.hasSearch = true,
    this.value,
    this.showClearButton = true,
    this.supportNull = true,
  });

  @override
  State<MyDurationOfStayPicker> createState() => _MyDurationOfStayPickerState();
}

const durationUnitsArray = ['HOURS',"DAYS","WEEKS","MONTHS","YEARS", ];
class _MyDurationOfStayPickerState<T> extends State<MyDurationOfStayPicker> {
  TextEditingController controller = TextEditingController();
  late ValueNotifier<DurationOfStay?> dosNotifier = ValueNotifier<DurationOfStay?>(widget.value);

  @override
  void initState() {
    controller = TextEditingController(text: widget.value?.toString() ?? '');
    dosNotifier.addListener(() {
      Future(() {
        controller.text = dosNotifier.value?.formatDurationUnit ?? '';
        widget.onChange?.call(dosNotifier.value);
        setState(() {});
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    dosNotifier.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MyDurationOfStayPicker oldWidget) {
    if (widget.value != oldWidget.value && mounted) {
      controller.text = widget.value == null ? "" : widget.value!.formatDurationUnit;
      dosNotifier.value = widget.value;
      setState(() {});
    }
    // controller.dropDownValue =widget.value==null?null: DropDownValueModel(name: widget.value?.toString()??'', value: widget.value, builder: widget.builder);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ValueListenableBuilder<DurationOfStay?>(
      valueListenable: dosNotifier,
      builder: (context, v, _) {
        return InkWell(
          onTap: () {
            var adapter = PickerDataAdapter(
              isArray: true,
              pickerData: [List.generate(999, (index) => index), durationUnitsArray],
              //value: value?.timeUnit,
            );

            List<int> initialSelection = (dosNotifier.value == null) ? [] : [dosNotifier.value!.duration, durationUnitsArray.indexOf(dosNotifier.value!.timeUnit)];

            Picker picker = Picker(
                selecteds: initialSelection,
                height: 200,
                builderHeader: (context) => Column(
                  children: [
                    // Row(children: [
                    //   MyButton(
                    //     flat: true,
                    //     color: Colors.grey,
                    //     onPressed: () {
                    //       adapter.picker!.doCancel(context);
                    //     },
                    //     label: "Cancel",
                    //     fontSize: 11,
                    //   ),
                    //   const SizedBox(width: 12),
                    //   Expanded(
                    //     child: MyButton(
                    //       onPressed: () {
                    //         adapter.picker!.doConfirm(context);
                    //       },
                    //       label: "Confirm",
                    //       fontSize: 11,
                    //     ),
                    //   ),
                    // ],),
                    // Divider(),
                    const SizedBox(height: 12),
                    const Text('Duration Of Stay', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Divider(),
                  ],
                ),
                // confirm: MyButton(
                //   fade: true,
                //   onPressed: () {
                //     adapter.picker!.doConfirm(context);
                //   },
                //   label: "Confirm",
                //   fontSize: 11,
                // ),
                // cancel: MyButton(
                //   flat: true,
                //   color: Colors.grey,
                //   onPressed: () {
                //     adapter.picker!.doCancel(context);
                //   },
                //   label: "Cancel",
                //   fontSize: 11,
                // ),
                //confirmTextStyle: const TextStyle(fontSize: 13, color: Colors.redAccent, backgroundColor: Colors.white),
                // confirm: SizedBox(),
                cancel: SizedBox(),
                changeToFirst:false,
                adapter: adapter,
                footer: SafeArea(
                  bottom: true,
                  top: false,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(children: [
                          MyButton(
                            flat: true,
                            color: Colors.black,
                            onPressed: () {
                              adapter.picker!.doCancel(context);
                              dosNotifier.value = null;
                              setState((){});
                            },
                            label: "Clear",
                            fontSize: 11,
                          ),
                          Spacer(),
                          MyButton(
                            flat: true,
                            color: Colors.grey,
                            onPressed: () {
                              adapter.picker!.doCancel(context);
                            },
                            label: "Cancel",
                            fontSize: 11,
                          ),
                          const SizedBox(width: 12),
                          MyButton(
                            onPressed: () {
                              adapter.picker!.doConfirm(context);
                            },
                            label: "Confirm",
                            fontSize: 11,
                          ),
                        ],),
                      ),
                    ],
                  ),
                ),
                textAlign: TextAlign.left,
                columnPadding: const EdgeInsets.all(8.0),
                onConfirm: (Picker picker, List value) {
                  DurationOfStay durationOfStay = DurationOfStay(
                    duration: value[0],
                    timeUnit: durationUnitsArray[value[1]],
                  );
                  if (durationOfStay.timeUnit == "HOURS" && durationOfStay.duration > 24) {
                    durationOfStay.timeUnit = "DAYS";
                    durationOfStay.duration = (durationOfStay.duration / 24).floor();
                  }
                  dosNotifier.value = durationOfStay;
                  setState((){});
                  // onChange?.call(durationOfStay);
                });
            // picker.showDialog(context);
            picker.showModal(context);
          },
          child: AbsorbPointer(
            child: MyTextFieldNew(
              rowLabelRatio: widget.rowLabelRatio,
              showError: false,
              headerBgColor: widget.headerBgColor,
              bodyBgColor: widget.bodyBgColor,
              required: widget.required,
              fontSize: 12,
              labelInRow: true,
              controller: controller,
              borderSide: BorderSide(color: Colors.white, width: 1),
              radius: BorderRadius.circular(8),
              label: widget.label,
              placeholder: widget.placeholder,
              suffixIcon: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.keyboard_arrow_down,size: 18,),
                  )),
              // suffixIcon:widget.value == null? Icon(Icons.arrow_drop_down):DotButton(icon: Icons.clear,onPressed: (){},flat: true,),
            ),
          ),
        );
      },
    );
  }
}

