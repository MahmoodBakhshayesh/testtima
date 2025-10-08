import 'dart:convert';
import 'dart:developer';
import 'package:abds/core/utils_and_services/artemis_icons_icons.dart';
import 'package:abds/widgets/AirlineLogo.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:abds/widgets/drawer_action.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/classes/basic_class.dart';
import '../../core/classes/outbox_message_class.dart';
import '../../core/constants/ui.dart';
import 'outbox_controller.dart';
import 'outbox_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';

class OutboxViewPhone extends StatefulWidget {
  const OutboxViewPhone({super.key});

  @override
  State<OutboxViewPhone> createState() => _OutboxViewPhoneState();
}

class _OutboxViewPhoneState extends State<OutboxViewPhone> {
  static OutboxController myOutboxController = getIt<OutboxController>();
  TextEditingController searchC = TextEditingController();
  bool loading = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((a) {
      myOutboxController.getOutboxMessages().then((a) {
        loading = false;
        setState(() {});
      });
    });
    searchC.addListener(() => setState(() {}));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OutboxAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: CupertinoTextField(
                      prefix: Padding(padding: const EdgeInsets.all(8.0), child: Icon(ArtemisIcons.search_normal)),
                      controller: searchC,
                      keyboardType: TextInputType.numberWithOptions(signed: true),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: loading
                ? SpinKitChasingDots(size: 50, color: context.mainColor)
                : Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      final messages = ref.watch(outboxMessagesProvider).reversed.where((a) => a.validateSearch(searchC.text)).toList();

                      return ListView.builder(
                        itemBuilder: (c, i) {
                          final message = messages[i];
                          return OutboxMessageWidget(
                            key: Key(message.showCode!),
                            onTap: () async {
                              await myOutboxController.goMessageDetails(message.showCode!);
                            },
                            message: message,
                            index: i,
                          );
                        },
                        itemCount: messages.length,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class OutboxAppBar extends StatelessWidget implements PreferredSizeWidget {
  static OutboxController myOutboxController = getIt<OutboxController>();

  const OutboxAppBar({super.key});

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
                      Text("Outbox", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
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

class OutboxMessageWidget extends StatefulWidget {
  final OutboxMessage message;
  final int index;
  final Function? onTap;

  const OutboxMessageWidget({Key? key, required this.message, required this.index, this.onTap}) : super(key: key);

  @override
  State<OutboxMessageWidget> createState() => _OutboxMessageWidgetState();
}

class _OutboxMessageWidgetState extends State<OutboxMessageWidget> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool isOdd = widget.index % 2 != 0;
    const TextStyle headerTextStyle = TextStyle(fontWeight: FontWeight.w600, color: MyColors.black, fontSize: 11);
    // final response = widget.message.supervisor?.firstOrNull?.getRes;
    // final currentStatus = BasicClass.getResultOfCode(widget.message.totalResult);
    final currentStatus = BasicClass.getResultOfCode(widget.message.totalResult);
    final airlineResponse =widget.message.airlineApproval==null?null: BasicClass.getResultOfCode(widget.message.airlineApproval);
    final response = widget.message.supervisor?.firstOrNull?.getRes;
    final superResponse = airlineResponse?? BasicClass.getResultOfCode(widget.message.supervisor.firstOrNull?.action??1)!;

    return Container(
      margin: const EdgeInsets.only(left: 12.0, right: 12, top: 12),
      child: Material(
        color:airlineResponse?.getColor.withOpacity(0.12)?? superResponse?.getColor.withOpacity(0.12) ?? Colors.black12,
        borderRadius: BorderRadiusGeometry.circular(12),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadiusGeometry.circular(12)),

          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () async {
              if (loading) {
                return;
              }
              loading = true;
              setState(() {});
              await widget.onTap?.call();
              loading = false;
              setState(() {});
            },
            child: Container(
              padding: const EdgeInsets.all(12),

              // decoration: BoxDecoration(color: response?.getColor.withOpacity(0.12)??Colors.white,borderRadius: BorderRadiusGeometry.circular(12)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            !widget.message.read ? Icon(Icons.circle, size: 10, color: Colors.red) : Icon(Icons.check_outlined, size: 10, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text("To: ${widget.message.user}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          ],
                        ),
                      ),
                      loading ? SpinKitThreeBounce(color: Colors.black, size: 20) : SizedBox(),
                      const SizedBox(width: 4),
                     Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.12),
                                borderRadius: BorderRadiusGeometry.circular(12),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Text(airlineResponse?.title??response?.name2 ?? '', style: TextStyle(fontSize: 12,color: superResponse.getColor)),
                            ),

                      // Expanded(child: Text(widget.message.code ?? '')),
                      // loading?SpinKitThreeBounce(color: context.mainColor,size: 20,):
                      // Text("${widget.message.user?.username ?? widget.message?.user?.email}"),
                      const SizedBox(width: 4),
                      Icon(Icons.arrow_forward_ios_rounded, size: 15),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text("Flight: ", style: TextStyle(color: Colors.grey, fontSize: 10)),
                            Text("${widget.message.airline ?? ''}${widget.message.flightNumber ?? ''}", style: TextStyle(fontSize: 10)),
                            Text(" / "),
                            Text("Nationality: ", style: TextStyle(color: Colors.grey, fontSize: 10)),
                            CountryFlag.fromCountryCode(widget.message.nationality, shape: RoundedRectangle(3), width: 15, height: 10),
                            Text(" ${widget.message.nationality}", style: TextStyle(fontSize: 10)),
                            Text(" / "),
                            Text("Route: ", style: TextStyle(color: Colors.grey, fontSize: 10)),
                            Text("${widget.message.from ?? ''}- ", style: TextStyle(fontSize: 10)),
                            CountryFlag.fromCountryCode(BasicClass.getAirportByCode(widget.message.to)?.country ?? '', shape: RoundedRectangle(3), width: 15, height: 10),
                            Text(" ${widget.message.to ?? ''}", style: TextStyle(fontSize: 10)),

                            // Text("Flight",style: TextStyle(color: Colors.grey),),
                            // AirlineLogo(widget.message.airline ?? '--',size: 30,),
                            // Text("${widget.message.airline ?? ''}${widget.message.flightNumber ?? ''}", style: TextStyle(fontSize: 14)),
                            // const SizedBox(width: 12),
                            // Text("${widget.message.from ?? ''}-${widget.message.to ?? ''}", style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(ArtemisIcons.send_2, color: Colors.grey, size: 10),
                      const SizedBox(width: 4),
                      Text(
                        "Employee ID: ",
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        widget.message.employeeId ?? "",
                        style: TextStyle(fontSize: 10, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.circle, color: Colors.grey, size: 5),
                      const SizedBox(width: 4),
                      Text(
                        "Tracking ID: ",
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        widget.message.showCode ?? "",
                        style: TextStyle(fontSize: 10, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(width: 2),
                      Text(currentStatus.title, style: TextStyle(color: currentStatus.getColor, fontSize: 10)),
                      const SizedBox(width: 2),
                      currentStatus.getIconWidgetMini,
                      Spacer(),
                      Text(
                        DateFormat("dd MMM, hh:mm").format(widget.message.createdAt!.toLocal()),
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                        textAlign: TextAlign.center,
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
