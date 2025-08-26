import 'dart:convert';

import 'package:abds/core/classes/timatic_log.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:json_view/json_view.dart';
import '../../core/constants/ui.dart';
import '../../core/utils_and_services/time_picker/ui_permission.dart';
import '../../widgets/MyButton.dart';
import '../../widgets/check_permission.dart';
import 'logs_controller.dart';
import 'logs_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';

class LogsViewPhone extends ConsumerStatefulWidget {
  const LogsViewPhone({super.key});

  @override
  ConsumerState<LogsViewPhone> createState() => _LogsViewPhoneState();
}

class _LogsViewPhoneState extends ConsumerState<LogsViewPhone> {
  static LogsController myLogsController = getIt<LogsController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myLogsController.getLogs();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool loading = ref.watch(logsLoadingProvider);
    final logs = ref.watch(logsProvider);
    return Scaffold(
      appBar: LogsAppBar(),
      body: Column(
        children: [
          Expanded(
            child: loading
                ? Center(child: SpinKitChasingDots(size: 44, color: context.mainColor))
                : ListView.builder(
                    itemCount: logs.length,
                    itemBuilder: (c, i) => LogWidget(log: logs[i], index: i),
                  ),
          ),
        ],
      ),
    );
  }
}

class LogsAppBar extends StatelessWidget implements PreferredSizeWidget {
  static LogsController myLogsController = getIt<LogsController>();

  const LogsAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(108);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: Colors.white,
      alignment: Alignment.center,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      BackButton(),
                      Text("Logs", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                      Spacer(),
                      SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () async {
                await myLogsController.getLogs();
              },
              icon: Icon(Icons.refresh),
            ),
          ],
        ),
      ),
    );
  }
}

class LogWidget extends StatelessWidget {
  final TimaticLog log;
  final int index;
  final void Function()? onTap;

  const LogWidget({super.key, required this.log, required this.index, this.onTap});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool isOdd = index % 2 != 0;
    const TextStyle headerTextStyle = TextStyle(fontWeight: FontWeight.w600, color: MyColors.black, fontSize: 11);
    Map<String, dynamic> input = jsonDecode(log.inputData ?? '{}');
    Map<String, dynamic> output = jsonDecode(log.outputData ?? '{}');
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: !isOdd ? MyColors.white2 : MyColors.white3),
        child: Container(
          color: Colors.white,
          child: ExpansionTile(
            childrenPadding: EdgeInsets.symmetric(horizontal: 12),
            tilePadding: EdgeInsets.symmetric(horizontal: 12),
            subtitle: Row(
              children: [
                Icon(log.result ? Icons.check_circle : Icons.error, color: log.result ? MyColors.green2 : Colors.red),
                const SizedBox(width: 8),
                Expanded(child: Text(log.username ?? '-')),
                Text(log.createdAt?.format_HHmmss ?? '', style: GoogleFonts.didactGothic(fontSize: 10)),
              ],
            ),
            title: Row(
              children: [
                Expanded(child: Text(log.title ?? '-')),
                CheckPermission(
                  permission: LogUiPermission.execute(),
                  child: MyButton(
                    label: "Execute",

                    onPressed: () async {
                      // await myCheckinController.logExecute(pax: widget.pax, history: his);
                    },
                    height: 30,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
              ],
            ),
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.blueAccent.withOpacity(0.1)),
                child: JsonView(gap: 12, shrinkWrap: true, json: input),
              ),
              Divider(height: 12),
              Container(
                decoration: BoxDecoration(color: Colors.green.withOpacity(0.1)),
                child: JsonView(gap: 12, shrinkWrap: true, json: output),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
