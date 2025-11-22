import 'dart:math';

import 'package:abds/widgets/DotButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetTimerDialog extends StatefulWidget {
  final int current;

  const SetTimerDialog({super.key, required this.current});

  @override
  State<SetTimerDialog> createState() => _SetTimerDialogState();
}

class _SetTimerDialogState extends State<SetTimerDialog> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    textEditingController.text = widget.current.toString();
    textEditingController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int? value = int.tryParse(textEditingController.text);
    bool valid = value != null;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          spacing: 12,
          children: [
            DotButton(
                icon: Icons.remove,
                onPressed: () {
                  textEditingController.text = "${max(0, (value ?? 0) - 1000)}";
                  setState(() {});
                }
            ),
            DotButton(
              icon: Icons.add,
              onPressed: () {
                textEditingController.text = "${max(0, (value ?? 0) + 1000)}";
                setState(() {});
              }
            ),
            Expanded(child: CupertinoTextField(
              keyboardType: TextInputType.numberWithOptions(signed: true),
              controller: textEditingController, placeholder: "Timer",)),
            DotButton(
              icon: Icons.check_circle,
              onPressed: valid
                  ? () {
                Navigator.pop(context, value);
              }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
