import 'package:abds/core/classes/server_mrz_result_class.dart';
import 'package:abds/screens/mrz_reader/mrz_reader_state.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ocr_mrz/ocr_mrz_settings_class.dart';

import '../../../core/classes/mrz_agg_class.dart';

class ConfirmServerMrzResultDialog extends StatefulWidget {
 final ServerMrzResult result;
  const ConfirmServerMrzResultDialog({super.key, required this.result});

  @override
  State<ConfirmServerMrzResultDialog> createState() => _MyOcrSettingDialogState();
}

class _MyOcrSettingDialogState extends State<ConfirmServerMrzResultDialog> {
  late ServerMrzResult tmp = widget.result;

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
              Expanded(child: Text("Confirm")),
              CloseButton()
            ],
          ),
          Divider(),
          Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8,top: 4),
                child: Row(children: [
                  Expanded(child: Center(child: Text("Field"))),
                  Expanded(child: Center(child: Text("Value"))),
                  Expanded(child: Center(child: Text("Accuracy"))),
                ],),
              )
            ),
            Divider(),
            FieldDataWidget(data: tmp.nationality, label: "Nationality"),
            FieldDataWidget(data: tmp.issueCountry, label: "Issuing"),
            FieldDataWidget(data: tmp.expiryDate, label: "Expiry Date"),
            FieldDataWidget(data: tmp.birthDate, label: "Birth Date"),
            FieldDataWidget(data: tmp.type, label: "Type"),
            FieldDataWidget(data: tmp.documentNumber, label: "Number"),
            FieldDataWidget(data: tmp.gender, label: "Gender"),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: MyButton(label: "Submit",onPressed: (){
                final ocrResult = tmp.getOcrMrzResult;
                Navigator.of(context).pop(ocrResult);
              },),
            )
            // FieldDataWidget(data: tmp.subType, label: "Nationality"),
            // ...tmp.histogram.keys.map((k){
            //   return Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //     child: Row(children: [
            //       Expanded(child: Text(k)),
            //       Text("${tmp.histogram[k]}")
            //     ],),
            //   );
            // })
          ],)
        ],
      ),
    );
  }
}

class FieldDataWidget extends StatelessWidget {
  final FieldData? data;
  final String label;

  const FieldDataWidget({super.key, required this.data, required this.label});
  @override
  Widget build(BuildContext context) {
    final d = data??FieldData(value: '',percent: 0);
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8,top: 4),
      child: Row(children: [
        Expanded(child: Text("$label")),
        Expanded(child: Center(child: Text("${d.value}"))),
        Expanded(child: Center(child: Text("${d.percent}"))),
      ],),
    );
  }
}

