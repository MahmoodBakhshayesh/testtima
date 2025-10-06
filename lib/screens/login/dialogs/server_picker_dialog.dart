import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/classes/server_class.dart';
import '../../../core/constants/ui.dart';
import '../../../initialize.dart';
import '../../../widgets/MyButton.dart';
import '../login_controller.dart';
import '../login_state.dart';

class ServerPickerDialog extends StatefulWidget {
  final List<Server> servers;
  final Server? currentServer;

  const ServerPickerDialog({super.key, required this.servers, this.currentServer});

  @override
  State<ServerPickerDialog> createState() => _ServerPickerDialogState();
}

class _ServerPickerDialogState extends State<ServerPickerDialog> {
  Server? tmpServer;

  @override
  void initState() {
    tmpServer = widget.currentServer;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: Container(
        constraints: BoxConstraints(maxHeight: height * 0.75),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Text("Available Servers", style: TextStyles.styleBold16Black),
            ),
            const Divider(),
            Expanded(
              child: ListView(
                children: widget.servers.map((e) {
                  // log("${(tmpServer?.apiAddress)?.toLowerCase()} vs ${(e.apiAddress).toLowerCase()}");
                  if (!e.active) {
                    return SizedBox();
                  }
                  return Container(
                    color: e.getColor.withOpacity(0.08),
                    child: RadioListTile<String>(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                      groupValue: (tmpServer?.apiAddress)?.toLowerCase(),
                      activeColor: theme.primaryColor,
                      title: Text(e.title),
                      value: (e.apiAddress).toLowerCase(),
                      onChanged: (String? value) {
                        setState(() {
                          tmpServer = widget.servers.firstWhereOrNull((a) => a.apiAddress == value);
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24, bottom: 24),
              child: Row(
                children: [
                  const Spacer(),
                  MyButton(
                    flat: true,
                    label: "Cancel",
                    color: Colors.grey,
                    onPressed: () {
                      getIt<LoginController>().navigation.popAllBottomSheets();
                    },
                  ),
                  const SizedBox(width: 24),
                  MyButton(
                    label: "Apply",
                    onPressed: () {
                      tmpServer = tmpServer?.copyWith(apiAddress: "${tmpServer!.apiAddress}$apiVersion");
                      getIt<LoginController>().navigation.popAllBottomSheets(result: tmpServer);
                    },
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
