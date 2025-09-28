import 'dart:convert';
import 'dart:developer';

import 'package:abds/core/classes/basic_class.dart';
import 'package:abds/core/classes/ref_history_log_class.dart';
import 'package:abds/core/constants/ui.dart';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/core/interfaces/local_data_base_int.dart';
import 'package:abds/core/utils_and_services/artemis_icons_icons.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:abds/widgets/MyTextFieldNew.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:dartx/dartx.dart';
import 'package:easy_animated_indexed_stack/easy_animated_indexed_stack.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../initialize.dart';
import '../../../widgets/DotButton.dart';
import '../../login/login_state.dart';
import '../dialogs/photo_preview_dialog.dart';
import '../dialogs/voice_preview_dialog.dart';
import '../home_controller.dart';
import '../home_state.dart';

class LogsAndAttachmentsWidget extends ConsumerWidget {
  const LogsAndAttachmentsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logs = ref.watch(showingLogsProvider);

    return Column(
      children: [
        ...logs.map((l) {
          switch (l.payload?.action) {
            case null:
              return SizedBox();
            case "askSupervisor":
              return SizedBox();
              return AskSupervisorWidget(his: l);
            case "managerApproval":
              return ManagerApprovalWidget(his: l);
            case "supervisorApproval":
              return SupervisorApprovalWidget(his: l);
            default:
              return SizedBox();
          }
        }).toList(),
        AttachmentsWidget(hisList: logs.where((a) => ["attachVoice", "attachPhoto"].contains(a.payload?.action)).toList()),
        ...logs.map((l) {
          switch (l.payload?.action) {
            case null:
              return SizedBox();
            case "e-visa":
              return EVisaWidget(his: l);
            case "comment":
              return CommentWidget(his: l);
            default:
              return SizedBox();
          }
        }).toList(),
      ],
    );
    return Container();
  }
}

class HeaderAskSupervisorWidget extends ConsumerWidget {
  const HeaderAskSupervisorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logs = ref.watch(showingLogsProvider);
    final asks = logs.lastOrNullWhere((a)=>a.payload?.action == "askSupervisor");
    if(asks == null){
      return SizedBox();
    }
    return AskSupervisorWidget(his: asks);
    return Column(
      children: [

        ...logs.map((l) {
          switch (l.payload?.action) {
            case null:
              return SizedBox();
            case "askSupervisor":
              return AskSupervisorWidget(his: l);
            default:
              return SizedBox();
          }
        }),
      ],
    );
    return Container();
  }
}

class AskSupervisorWidget extends StatefulWidget {
  final RefHistoryLog his;

  const AskSupervisorWidget({super.key, required this.his});

  @override
  State<AskSupervisorWidget> createState() => _AskSupervisorWidgetState();
}

class _AskSupervisorWidgetState extends State<AskSupervisorWidget> {
  TextEditingController commentC = TextEditingController();
  String? msg;
  int? status;

  @override
  Widget build(BuildContext context) {
    final selectionColor = Color(0xff2A5CFF);
    final greenColor = Color(0xff08AB7D);
    final redColor = Color(0xffFF3F42);
    final blackColor = Color(0xff2D2D2D);
    log(jsonEncode(widget.his.toJson()));
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // color: Color(0xff2A5CFF).withOpacity(.08)
        color: Colors.white,
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Supervisor Response", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          widget.his.payload?.message == null
              ? SizedBox()
              : Container(
                  margin: EdgeInsets.symmetric(vertical: 12),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(color: MyColors.mainBlue.withOpacity(0.08), borderRadius: BorderRadiusGeometry.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(widget.his.user?.username??'-',style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                      Text(widget.his.payload!.message!),
                    ],
                  ),
                ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: MyTextFieldNew(headerBgColor: selectionColor.withOpacity(0.2),
          //           bodyBgColor: Color(0xffF0F2F8),
          //           radius: BorderRadius.circular(12),
          //           label: "Comment",
          //           controller: commentC,
          //           placeholder: "Enter Comment"),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 12),
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: MyButton(
                  color: greenColor,
                  fontSize: 12,
                  radius: 12,
                  label: "Approve",
                  onPressed: () {
                    if (status == 1) {
                      status = null;
                    } else {
                      status = 1;
                    }
                    setState(() {});
                  },
                  icon: ArtemisIcons.tick_square,
                  reverse: status != 1,
                  borderSide: BorderSide(color: greenColor),
                ),
              ),
              Expanded(
                child: MyButton(
                  color: redColor,
                  radius: 12,
                  fontSize: 12,
                  label: "Deny",
                  onPressed: () {
                    if (status == 2) {
                      status = null;
                    } else {
                      status = 2;
                    }
                    setState(() {});
                  },
                  icon: ArtemisIcons.close_square,
                  reverse: status != 2,
                  borderSide: BorderSide(color: redColor),
                ),
              ),
              Expanded(
                child: MyButton(
                  color: blackColor,
                  radius: 12,
                  fontSize: 12,
                  label: "Wait",
                  onPressed: () {
                    if (status == 3) {
                      status = null;
                    } else {
                      status = 3;
                    }
                    setState(() {});
                  },
                  icon: ArtemisIcons.timer,
                  reverse: status != 3,
                  borderSide: BorderSide(color: blackColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AnimatedContainer(
            height: status == 3
                ? (BasicClass.constData.data.textMessage.length * 50)
                : status == 1
                ? 40
                : status == 2
                ? 40
                : 0,
            duration: Duration(milliseconds: 200),
            child: status == 3
                ? Column(
                    spacing: 8,
                    children: [
                      ...BasicClass.constData.data.textMessage.map((a) {
                        bool selected = msg == a;
                        return MyButton(
                          radius: 20,
                          label: a,
                          // reverse: true,
                          color: selected ? selectionColor.withOpacity(0.08) : Colors.transparent,
                          borderSide: BorderSide(color: selectionColor.withOpacity(0.08)),
                          onPressed: () {
                            if (selected) {
                              msg = null;
                            } else {
                              msg = a;
                            }
                            setState(() {});
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off, color: selected ? selectionColor : Colors.black),
                              ),
                              Expanded(
                                child: Text(a, style: TextStyle(color: selected ? selectionColor : Colors.black)),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  )
                : status == 1
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: greenColor.withOpacity(0.08), borderRadius: BorderRadiusGeometry.circular(10)),
                    child: Row(
                      children: [Text("Passenger is OK to travel", style: TextStyle(color: greenColor))],
                    ),
                  )
                : status == 2
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: redColor.withOpacity(0.08), borderRadius: BorderRadiusGeometry.circular(10)),
                    child: Row(
                      children: [Text("Passenger is Rejected to travel", style: TextStyle(color: redColor))],
                    ),
                  )
                : SizedBox(),
          ),
          const SizedBox(height: 12),
          MyButton(
            label: "Send",
            onPressed: status == null
                ? null
                : () async {
                    await getIt<HomeController>().attachToResult(logId: getIt<HomeController>().ref.read(refCodeProvider) ?? '-', data: {"action": "supervisorApproval", 'status': status, "message": msg});
                  },
            radius: 12,
            icon: ArtemisIcons.send,
            iconInRight: true,
          ),
        ],
      ),
    );
  }
}

class AskSupervisorWidgetNew extends StatefulWidget {
  final RefHistoryLog his;

  const AskSupervisorWidgetNew({super.key, required this.his});

  @override
  State<AskSupervisorWidgetNew> createState() => _AskSupervisorWidgetNewState();
}

class _AskSupervisorWidgetNewState extends State<AskSupervisorWidgetNew> {
  TextEditingController commentC = TextEditingController();
  String? msg;
  int? status;

  @override
  Widget build(BuildContext context) {
    final selectionColor = Color(0xff2A5CFF);
    final greenColor = Color(0xff08AB7D);
    final redColor = Color(0xffFF3F42);
    final blackColor = Color(0xff2D2D2D);
    return Container(
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // color: Color(0xff2A5CFF).withOpacity(.08)
        color: Colors.white,
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Supervisor", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: MyTextFieldNew(headerBgColor: selectionColor.withOpacity(0.2), bodyBgColor: Color(0xffF0F2F8), radius: BorderRadius.circular(12), label: "Comment", controller: commentC, placeholder: "Enter Comment"),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: MyButton(
                  color: greenColor,
                  fontSize: 12,
                  radius: 12,
                  label: "Approved",
                  onPressed: () {
                    if (status == 1) {
                      status = null;
                    } else {
                      status = 1;
                    }
                    setState(() {});
                  },
                  icon: ArtemisIcons.tick_square,
                  reverse: status != 1,
                  borderSide: BorderSide(color: greenColor),
                ),
              ),
              Expanded(
                child: MyButton(
                  color: redColor,
                  radius: 12,
                  fontSize: 12,
                  label: "Deny",
                  onPressed: () {
                    if (status == 2) {
                      status = null;
                    } else {
                      status = 2;
                    }
                    setState(() {});
                  },
                  icon: ArtemisIcons.close_square,
                  reverse: status != 2,
                  borderSide: BorderSide(color: redColor),
                ),
              ),
              Expanded(
                child: MyButton(
                  color: blackColor,
                  radius: 12,
                  fontSize: 12,
                  label: "Wait",
                  onPressed: () {
                    if (status == 3) {
                      status = null;
                    } else {
                      status = 3;
                    }
                    setState(() {});
                  },
                  icon: ArtemisIcons.timer,
                  reverse: status != 3,
                  borderSide: BorderSide(color: blackColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AnimatedContainer(
            height: status == 3 ? (BasicClass.constData.data.textMessage.length * 50) : 0,
            duration: Duration(milliseconds: 200),
            child: status == 3
                ? Column(
                    spacing: 8,
                    children: [
                      ...BasicClass.constData.data.textMessage.map((a) {
                        bool selected = msg == a;
                        return MyButton(
                          radius: 20,
                          label: a,
                          // reverse: true,
                          color: selected ? selectionColor.withOpacity(0.08) : Colors.transparent,
                          borderSide: BorderSide(color: selectionColor.withOpacity(0.08)),
                          onPressed: () {
                            if (selected) {
                              msg = null;
                            } else {
                              msg = a;
                            }
                            setState(() {});
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off, color: selected ? selectionColor : Colors.black),
                              ),
                              Expanded(
                                child: Text(a, style: TextStyle(color: selected ? selectionColor : Colors.black)),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  )
                : SizedBox(),
          ),
          const SizedBox(height: 12),
          MyButton(
            label: "Send",
            onPressed: () async {
              await getIt<HomeController>().attachToResult(logId: getIt<HomeController>().ref.read(refCodeProvider) ?? '-', data: {"action": "supervisorApproval", 'status': status, "message": msg});
            },
            radius: 12,
            icon: ArtemisIcons.send,
            iconInRight: true,
          ),
        ],
      ),
    );
  }
}

class ManagerApprovalWidget extends StatelessWidget {
  final RefHistoryLog his;

  const ManagerApprovalWidget({super.key, required this.his});

  @override
  Widget build(BuildContext context) {
    bool approved = his.payload?.approved ?? false;
    final color = approved ? Color(0xff00C68E) : Color(0xffFF3F42);
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
      decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(approved ? ArtemisIcons.shield_tick : ArtemisIcons.user_octagon, color: color),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    "Airline Representative",
                    style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(his.at?.toLocal().format_HHmm ?? '', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [color.withOpacity(0.08), color.withOpacity(0.00)]),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(approved ? ArtemisIcons.tick_square : ArtemisIcons.close_square, color: color),
                      const SizedBox(width: 4),
                      Text(
                        approved ? "Approved" : "Denied",
                        style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.48),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white),
                  ),
                  margin: EdgeInsets.all(12),
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        his.payload?.name ?? '',
                        style: TextStyle(fontWeight: FontWeight.bold, color: color),
                      ),
                      Text(his.payload?.message ?? ''),
                      (his.payload?.attachFiles ?? []).isEmpty
                          ? SizedBox()
                          : Row(
                              children: [
                                Expanded(
                                  child: Wrap(
                                    children: [
                                      ...(his.payload?.attachFiles ?? []).map((img) {
                                        String api = getIt<HomeController>().ref.read(selectedServerProvider)!.apiAddress;
                                        String token = getIt<HomeController>().ref.read(userProvider)!.token;
                                        bool isVoice = img.endsWith("m4a");
                                        if (isVoice) {
                                          return Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: DotButton(
                                              size: 40,
                                              icon: Icons.record_voice_over,
                                              onPressed: () async {
                                                String dlUrl = "${api}/logs/attach/${img}";
                                                final f = await getIt<HomeController>().getFile(url: dlUrl);
                                                log(f.path);
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return VoicePreviewDialog(address: f.path);
                                                  },
                                                );
                                              },
                                            ),
                                          );
                                        }
                                        return GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return PhotoPreviewDialog(address: img);
                                              },
                                            );
                                          },
                                          child: SizedBox(
                                            width: 120,
                                            height: 120,
                                            child: ClipRRect(
                                              borderRadius: BorderRadiusGeometry.circular(5),
                                              child: Image.network("${api}/logs/attach/$img", fit: BoxFit.fill, headers: {"Authorization": "Bearer ${token}"}),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SupervisorApprovalWidget extends StatelessWidget {
  final RefHistoryLog his;

  const SupervisorApprovalWidget({super.key, required this.his});

  @override
  Widget build(BuildContext context) {
    // bool approved = his.payload?.approved ?? false;
    final int status = his.payload?.status ?? 3;
    final color = [Color(0xff00C68E), Color(0xffFF3F42), Colors.black][status - 1];
    final title = ["Approved", "Denied", "Wait"][status - 1];
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
      decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(status == 1 ? ArtemisIcons.shield_tick : ArtemisIcons.user_octagon, color: color),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    "Supervisor",
                    style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(his.at?.toLocal().format_HHmm ?? '', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [color.withOpacity(0.08), color.withOpacity(0.00)]),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(status == 1 ? ArtemisIcons.tick_square : ArtemisIcons.close_square, color: color),
                      const SizedBox(width: 4),
                      Text(
                        title,
                        style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.48),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white),
                  ),
                  margin: EdgeInsets.all(12),
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            his.payload?.name ?? '',
                            style: TextStyle(fontWeight: FontWeight.bold, color: color),
                          ),
                        ],
                      ),
                      Text(his.payload?.message ?? ''),
                      (his.payload?.attachFiles ?? []).isEmpty
                          ? SizedBox()
                          : Row(
                              children: [
                                Expanded(
                                  child: Wrap(
                                    children: [
                                      ...(his.payload?.attachFiles ?? []).map((img) {
                                        String api = getIt<HomeController>().ref.read(selectedServerProvider)!.apiAddress;
                                        String token = getIt<HomeController>().ref.read(userProvider)!.token;
                                        bool isVoice = img.endsWith("m4a");
                                        if (isVoice) {
                                          return Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: DotButton(
                                              size: 40,
                                              icon: Icons.record_voice_over,
                                              onPressed: () async {
                                                String dlUrl = "${api}/logs/attach/${img}";
                                                final f = await getIt<HomeController>().getFile(url: dlUrl);
                                                log(f.path);
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return VoicePreviewDialog(address: f.path);
                                                  },
                                                );
                                              },
                                            ),
                                          );
                                        }
                                        return GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return PhotoPreviewDialog(address: img);
                                              },
                                            );
                                          },
                                          child: SizedBox(
                                            width: 120,
                                            height: 120,
                                            child: ClipRRect(
                                              borderRadius: BorderRadiusGeometry.circular(5),
                                              child: Image.network("${api}/logs/attach/$img", fit: BoxFit.fill, headers: {"Authorization": "Bearer ${token}"}),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AttachmentsWidget extends StatelessWidget {
  final List<RefHistoryLog> hisList;

  const AttachmentsWidget({super.key, required this.hisList});

  @override
  Widget build(BuildContext context) {
    final color = Colors.black;
    final List<String> photos = [];
    final List<String> voices = [];
    hisList.where((a) => a.payload?.action == "attachPhoto").forEach((p) {
      photos.addAll(p.payload?.attachFiles ?? []);
    });
    hisList.where((a) => a.payload?.action == "attachVoice").forEach((p) {
      voices.addAll(p.payload?.attachFiles ?? []);
    });
    if (hisList.isEmpty) {
      return SizedBox();
    }
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
      decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(ArtemisIcons.attach_circle, color: color),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    "Attachments",
                    style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(hisList.last.at?.toLocal().format_HHmm ?? '', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.48),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white),
            ),
            margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  child: GridView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 4, crossAxisSpacing: 4),
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ...photos.map((img) {
                        String api = getIt<HomeController>().ref.read(selectedServerProvider)!.apiAddress;
                        String token = getIt<HomeController>().ref.read(userProvider)!.token;
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return PhotoPreviewDialog(address: img);
                              },
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(5),
                            child: Image.network("${api}/logs/attach/$img", fit: BoxFit.fill, headers: {"Authorization": "Bearer ${token}"}),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Column(
                  spacing: 8,
                  children: [
                    ...voices.map((img) {
                      String api = getIt<HomeController>().ref.read(selectedServerProvider)!.apiAddress;
                      String token = getIt<HomeController>().ref.read(userProvider)!.token;
                      return MyButton(
                        label: "Play Audio",
                        icon: ArtemisIcons.play_circle,
                        reverse: true,
                        radius: 12,
                        borderSide: BorderSide(color: context.mainColor),
                        onPressed: () async {
                          String dlUrl = "${api}/logs/attach/${img}";
                          final f = await getIt<HomeController>().getFile(url: dlUrl);
                          log(f.path);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return VoicePreviewDialog(address: f.path);
                            },
                          );
                        },
                      );
                    }).toList(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EVisaWidget extends StatelessWidget {
  final RefHistoryLog his;

  const EVisaWidget({super.key, required this.his});

  @override
  Widget build(BuildContext context) {
    final color = Color(0xff08AB7D);
    final List<String> evisas = his.payload?.attachFiles ?? [];
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
      decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(ArtemisIcons.note_2, color: color),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    "E-Visa",
                    style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(his.at?.toLocal().format_HHmm ?? '', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.48),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white),
            ),
            margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  child: GridView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 4, crossAxisSpacing: 4),
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ...evisas.map((img) {
                        String api = getIt<HomeController>().ref.read(selectedServerProvider)!.apiAddress;
                        String token = getIt<HomeController>().ref.read(userProvider)!.token;
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return PhotoPreviewDialog(address: img);
                              },
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(5),
                            child: Image.network("${api}/logs/attach/$img", fit: BoxFit.fill, headers: {"Authorization": "Bearer ${token}"}),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommentWidget extends StatelessWidget {
  final RefHistoryLog his;

  const CommentWidget({super.key, required this.his});

  @override
  Widget build(BuildContext context) {
    final color = Color(0xffFFa32C);
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
      decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(ArtemisIcons.attach_circle, color: color),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    "Comments",
                    style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(his.at?.toLocal().format_HHmm ?? '', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.48),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white),
            ),
            margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [Text(his.payload?.comment ?? '')]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
