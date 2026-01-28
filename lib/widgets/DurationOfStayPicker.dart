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
  final double? height;
  final Color? headerBgColor;
  final Color? bodyBgColor;
  final TextStyle? style;
  final List<int>  rowLabelRatio;
  final BorderRadius? radius;

  const MyDurationOfStayPicker({
    super.key,
    this.locked = false,
    this.rowLabelRatio = const[12,33],
    this.required = false,
    this.labelInRow = false,
    this.style,
    this.height,
    this.radius,
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
            _showWebPicker(context);
          },
          child: AbsorbPointer(
            child: MyTextFieldNew(
              rowLabelRatio: widget.rowLabelRatio,
              showError: false,
              height: widget.height,

              headerBgColor: widget.headerBgColor,
              bodyBgColor: widget.bodyBgColor,
              required: widget.required,
              backgroundColor: widget.bodyBgColor,
              fontSize: 14,
              labelInRow: widget.labelInRow,
              controller: controller,
              borderSide: BorderSide(color: Colors.white, width: 1),
              radius:widget.radius?? BorderRadius.circular(5),
              label: widget.label,
              placeholder: widget.placeholder,
              style: widget.style,
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

  void _showWebPicker(BuildContext context) {
    int? selectedDuration = dosNotifier.value?.duration;
    String? selectedUnit = dosNotifier.value?.timeUnit;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 400,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Duration Of Stay', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Divider(),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: 100,
                            itemBuilder: (context, index) {
                              final duration = index + 1;
                              return ListTile(
                                title: Text('$duration'),
                                onTap: () {
                                  setState(() {
                                    selectedDuration = duration;
                                  });
                                },
                                selected: selectedDuration == duration,
                                selectedTileColor: Theme.of(context).primaryColor.withOpacity(0.2),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: durationUnitsArray.length,
                            itemBuilder: (context, index) {
                              final unit = durationUnitsArray[index];
                              return ListTile(
                                title: Text(unit),
                                onTap: () {
                                  setState(() {
                                    selectedUnit = unit;
                                  });
                                },
                                selected: selectedUnit == unit,
                                selectedTileColor: Theme.of(context).primaryColor.withOpacity(0.2),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                    child: Row(
                      children: [
                        MyButton(
                          flat: true,
                          color: Colors.black,
                          onPressed: () {
                            Navigator.pop(context);
                            dosNotifier.value = null;
                          },
                          label: "Clear",
                          fontSize: 11,
                        ),
                        Spacer(),
                        MyButton(
                          flat: true,
                          color: Colors.grey,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          label: "Cancel",
                          fontSize: 11,
                        ),
                        const SizedBox(width: 12),
                        MyButton(
                          onPressed: () {
                            if (selectedDuration != null && selectedUnit != null) {
                              DurationOfStay durationOfStay = DurationOfStay(
                                duration: selectedDuration!,
                                timeUnit: selectedUnit!,
                              );
                              if (durationOfStay.timeUnit == "HOURS" && durationOfStay.duration > 24) {
                                durationOfStay.timeUnit = "DAYS";
                                durationOfStay.duration = (durationOfStay.duration / 24).floor();
                              }
                              dosNotifier.value = durationOfStay;
                            }
                            Navigator.pop(context);
                          },
                          label: "Confirm",
                          fontSize: 11,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
