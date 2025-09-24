import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:abds/screens/home/home_view_phone.dart';
import 'package:flutter/material.dart';

class TranslatedResponseDialog extends StatelessWidget {
  final DocumentResponse translated;

  const TranslatedResponseDialog({super.key, required this.translated});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
            child: Row(children: [
              const SizedBox(width: 16),
              Expanded(child: Text("Translated Overview",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),)),
              CloseButton(),
            ],),
          ),
          Divider(height: 1,),
          Expanded(child: SingleChildScrollView(
            child: Column(
              children: [
                TimaticTrueResultWidget(res: translated),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
