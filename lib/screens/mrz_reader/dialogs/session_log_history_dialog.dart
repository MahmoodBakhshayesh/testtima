import 'package:abds/screens/mrz_reader/mrz_reader_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ocr_mrz/ocr_mrz_settings_class.dart';
import 'package:ocr_mrz/session_status_class.dart';

import '../../../core/classes/mrz_agg_class.dart';

class SessionLogHistoryDialog extends StatefulWidget {
  final List<SessionStatus> sl;

  const SessionLogHistoryDialog({super.key, required this.sl});

  @override
  State<SessionLogHistoryDialog> createState() => _MyOcrSettingDialogState();
}

class _MyOcrSettingDialogState extends State<SessionLogHistoryDialog> {

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
              Expanded(child: Text("Session Log")),
              CloseButton()
            ],
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: widget.sl.length,
              itemBuilder: (c, i) {
                SessionStatus s = widget.sl[i];
                return ListTile(title: Text("$s"),subtitle: Text(s.logDetails??''),);
              },
            ),
          ),
        ],
      ),
    );
  }
}
