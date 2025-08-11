import 'package:flutter/material.dart';
import 'mrz_reader_controller.dart';
import 'mrz_reader_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';


class MrzReaderViewTablet extends StatelessWidget {
  static MrzReaderController myMrzReaderController = getIt<MrzReaderController>();
  const MrzReaderViewTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: MrzReaderAppBarTablet(),
        body: Column(children: [

        ],));
  }
}

class MrzReaderAppBarTablet extends StatelessWidget implements PreferredSizeWidget {
static MrzReaderController myMrzReaderController = getIt<MrzReaderController>();

const MrzReaderAppBarTablet({super.key});

@override
Size get preferredSize => const Size.fromHeight(108);

@override
Widget build(BuildContext context) {
return Container(
height: preferredSize.height,
color: context.mainColor,
alignment: Alignment.center,
child: const SafeArea(
child: Row(
children: [
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
mainAxisAlignment: MainAxisAlignment.center,
children: [
Row(
children: [
Text(
"MrzReader",
style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18),
),
Spacer(),
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
