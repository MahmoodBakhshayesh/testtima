import 'dart:ui';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../initialize.dart';
import '../../../screens/login/login_controller.dart';
import '../../../widgets/MyButton.dart';
import '../../constants/ui.dart';

class ConfirmOperation {
  static final navigationService = getIt<LoginController>().navigation;

  ConfirmOperation._();

  static Future<bool> getConfirm(Operation operation, {Function? retry}) async {
    final res = await navigationService.openDialog(dialog: ConfirmOperationDialog(operation: operation));
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

  Operation({this.type = OperationType.success, required this.message, required this.title, required this.actions, this.trueLabel = "Confirm", this.falseLabel = "Cancel"});
}

enum OperationType { success, warning, error }

extension OperationTypeDetails on OperationType {
  Color get color {
    switch (this) {
      case OperationType.success:
        return MyColors.lightIshBlue;
      case OperationType.warning:
        return MyColors.macAndCheese;
      case OperationType.error:
        return MyColors.red;
    }
  }

  IconData get icon {
    switch (this) {
      case OperationType.success:
        return Icons.check_box;
      case OperationType.warning:
        return Icons.warning;
      case OperationType.error:
        return Icons.error;
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
                Icon(operation.type.icon, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  operation.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    navigationService.pop();
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
