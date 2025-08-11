import 'package:flutter/material.dart';
import 'mrz_reader_controller.dart';
import 'mrz_reader_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';


class MrzReaderViewDesktop extends StatelessWidget {
  static MrzReaderController myMrzReaderController = getIt<MrzReaderController>();
  const MrzReaderViewDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MrzReaderAppBarDesktop(),
        body: Column(children: [

        ],));
  }
}

class MrzReaderAppBarDesktop extends StatelessWidget implements PreferredSizeWidget {
static MrzReaderController myMrzReaderController = getIt<MrzReaderController>();

const MrzReaderAppBarDesktop({super.key});

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
