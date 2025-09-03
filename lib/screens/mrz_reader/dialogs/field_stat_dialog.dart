import 'package:abds/screens/mrz_reader/mrz_reader_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ocr_mrz/ocr_mrz_settings_class.dart';

import '../../../core/classes/mrz_agg_class.dart';

class FieldStatDialog extends StatefulWidget {
  final String label;
  final FieldStat stat;

  const FieldStatDialog({super.key, required this.stat, required this.label});

  @override
  State<FieldStatDialog> createState() => _MyOcrSettingDialogState();
}

class _MyOcrSettingDialogState extends State<FieldStatDialog> {
  late FieldStat tmp = widget.stat;

  @override
  Widget build(BuildContext context) {
    return Dialog(

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           Row(
             children: [
               const SizedBox(width: 12),
               Expanded(child: Text(widget.label)),
               CloseButton()
             ],
           ),
          Divider(),
          Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Expanded(child: Text("Value")),
                Text("Count")
              ],),
            ),
            Divider(),
            ...tmp.histogram.keys.map((k){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(children: [
                  Expanded(child: Text(k)),
                  Text("${tmp.histogram[k]}")
                ],),
              );
            })
          ],)
        ],
      ),
    );
  }
}
