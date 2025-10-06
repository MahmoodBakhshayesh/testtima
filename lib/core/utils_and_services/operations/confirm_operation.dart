import 'dart:ui';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../initialize.dart';
import '../../../screens/login/login_controller.dart';
import '../../../widgets/DotButton.dart';
import '../../../widgets/MyButton.dart';
import '../../constants/ui.dart';
import '../artemis_icons_icons.dart';

class ConfirmOperation {
  static final navigationService = getIt<LoginController>().navigation;

  ConfirmOperation._();

  static Future<bool> getConfirm(Operation operation, {Function? retry}) async {
    // final res = await navigationService.openDialog(dialog: ConfirmOperationDialog(operation: operation));
    final res = await navigationService.openBottomSheet(
      bottomSheet: ConfirmOperationSheet(operation: operation),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
    return res == true;
  }
}

class Operation {
  final OperationType type;
  final String title;
  final String message;
  final List<String> actions;
  final String trueLabel;
  final String falseLabel;
  final IconData? icon;

  Operation({this.type = OperationType.success, required this.message,   this.icon, required this.title, required this.actions, this.trueLabel = "Confirm", this.falseLabel = "Cancel"});
}

enum OperationType { success, warning, error }

extension OperationTypeDetails on OperationType {
  Color get color {
    switch (this) {
      case OperationType.success:
        return MyColors.lightIshBlue;
      case OperationType.warning:
        return MyColors.orange;
      case OperationType.error:
        return MyColors.red;
    }
  }

  IconData get icon {
    switch (this) {
      case OperationType.success:
        return ArtemisIcons.tick_square;
      case OperationType.warning:
        return ArtemisIcons.danger;
      case OperationType.error:
        return ArtemisIcons.wanchain_wan;
    }
  }
}

class ConfirmOperationDialog extends StatelessWidget {
  final Operation operation;
  final navigationService = getIt<LoginController>().navigation;

  ConfirmOperationDialog({super.key, required this.operation});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Dialog(
      insetPadding: context.getDialogPadding,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: operation.type.color,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
            ),
            child: Row(
              children: [
                const SizedBox(width: 18),
                Icon(operation.icon??operation.type.icon, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  operation.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                   navigationService.popAllBottomSheets();
                  },
                  icon: const Icon(Icons.close, color: Colors.white, size: 15),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(operation.message, style: GoogleFonts.openSans(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          const Divider(height: 1, thickness: 1),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 8),
            child: Row(
              children: [
                //TextButton(onPressed: () {}, child: const Text("Add")),
                const Spacer(),

                MyButton(onPressed: () => navigationService.pop(), label: operation.falseLabel, color: MyColors.greyishBrown, reverse: true, fontSize: 12),
                const SizedBox(width: 8),
                MyButton(
                  height: 35,
                  onPressed: () => navigationService.pop(result: true),
                  label: operation.trueLabel,
                  color: theme.primaryColor,
                  // reverse: true,
                  fontSize: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ConfirmOperationSheet extends StatelessWidget {
  final Operation operation;
  final navigationService = getIt<LoginController>().navigation;

  ConfirmOperationSheet({super.key, required this.operation});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Color color = Colors.black;
    Color warColor = Color(0xffBf6C00);
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          elevation: 5,
          borderRadius: BorderRadiusGeometry.circular(15),
          child: Container(
            // height: 100,
            decoration: BoxDecoration(
              // color: Colors.white,
              gradient: LinearGradient(colors: [warColor.withOpacity(0.0), warColor], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              borderRadius: BorderRadiusGeometry.circular(15),
              // border: Border.all(color: Colors.orange, width: 2),
            ),
            child: Container(
              margin: EdgeInsets.all(2),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadiusGeometry.circular(15)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(ArtemisIcons.warning_2, color:  operation.type.color, size: 30),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "${operation.title}",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: operation.type.color,),
                        ),
                      ),
                      const SizedBox(width: 4),
                      DotButton(
                        icon: Icons.close,
                        color: color,
                        // fade: false,
                        // backgroundColor: Colors.white.withOpacity(0.3),
                        radius: 10,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 12),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(operation.message, style: TextStyle(color: color, fontSize: 14)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    spacing: 12,
                    children: [
                      Expanded(
                        child: MyButton(
                          label: "Cancel",
                          icon: ArtemisIcons.close_square,
                          onPressed: () {
                            Navigator.pop(context,false);
                          },
                          radius: 12,
                          color: Colors.black,
                          reverse: true,
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: MyButton(
                          label: "I'm Sure, ${operation.title}",
                          icon: operation.icon,
                          onPressed: () {
                            Navigator.pop(context,true);
                          },
                          radius: 12,
                          color: operation.type.color,
                          reverse: true,
                          borderSide: BorderSide(color: operation.type.color),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
