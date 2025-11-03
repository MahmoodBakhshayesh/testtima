import 'dart:developer';

import 'package:abds/core/utils_and_services/cupps_util.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:abds/widgets/MyTextFieldNew.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/classes/basic_class.dart';
import '../../core/classes/constant_data_class.dart';
import '../../widgets/MyFieldPicker.dart';
import 'cupps_controller.dart';
import 'cupps_state.dart';
import '../../initialize.dart';
import '../../core/extenstions/context_exp.dart';

class CuppsViewDesktop extends ConsumerStatefulWidget {
  static CuppsController myCuppsController = getIt<CuppsController>();

  const CuppsViewDesktop({super.key});

  @override
  ConsumerState<CuppsViewDesktop> createState() => _CuppsViewPhoneState();
}

class _CuppsViewPhoneState extends ConsumerState<CuppsViewDesktop> {
  static CuppsController myCuppsController = getIt<CuppsController>();

  TextEditingController ipC = TextEditingController();
  TextEditingController portC = TextEditingController();

  ParameterValue? airline;
  Airport? airport;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myCuppsController.loadIpPort().then((v) {
        ipC.text = v.$1 ?? '';
        portC.text = v.$2 ?? '';
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final headerBgColor = Colors.greenAccent;
    final bodyBgColor = Colors.greenAccent.withOpacity(0.12);
    final cupps = ref.watch(cuppsStatusProvider);
    final cuppsPlatform = ref.watch(cuppsPlatformStatusProvider);

    return Scaffold(
      appBar: CuppsAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              spacing: 12,
              children: [
                Expanded(
                  flex: 2,
                  child: MyTextFieldNew(controller: ipC, headerBgColor: headerBgColor, bodyBgColor: bodyBgColor, labelInRow: true, label: "IP"),
                ),
                Expanded(
                  child: MyTextFieldNew(controller: portC, rowLabelRatio: [4, 7], headerBgColor: headerBgColor, bodyBgColor: bodyBgColor, labelInRow: true, label: "Port"),
                ),
                Expanded(
                  child: MyButton(
                    color: cuppsPlatform.getConnectColor,
                    label: cuppsPlatform.getConnectLabel,
                    onPressed: () async {
                      if (cuppsPlatform == CuppsPlatformStatus.connected) {
                        return;
                      }
                      await CuppsViewDesktop.myCuppsController.connectCupps(ipC.text, portC.text);
                    },
                  ),
                ),
                Expanded(
                  child: MyButton(
                    flat: true,
                    reverse: true,
                    color: cuppsPlatform.getColor,
                    label: cuppsPlatform.label,
                    onPressed: () async {
                      // String test = "�0P<BRASILVA<COSTA<<JOANA<<<<<<<<<<<<<<<<<<<<<AA000000<0BRA8101109F2508142<<<<<<<<<<<<<<02";
                      // CuppsUtils.ocDataHandlerText(test);
                    },
                  ),
                ),
                Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children:cupps==null?[]: [
                          Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 4,
                            runSpacing: 4,
                            children: [
                              ...cupps.bpDevices.map((d) {
                                return Image.asset(d.icon, package: 'artemis_cupps', width: 40, height: 40);
                              }),
                              ...cupps.btDevices.map((d) {
                                return Image.asset(d.icon, package: 'artemis_cupps', width: 40, height: 40);
                              }),
                              ...cupps.bgDevices.map((d) {
                                return Image.asset(d.icon, package: 'artemis_cupps', width: 40, height: 40);
                              }),
                              ...cupps.bcDevices.map((d) {
                                return Image.asset(d.icon, package: 'artemis_cupps', width: 40, height: 40);
                              }),
                              ...cupps.ddDevices.map((d) {
                                return Image.asset(d.icon, package: 'artemis_cupps', width: 40, height: 40);
                              }),
                              ...cupps.ocDevices.map((d) {
                                log("${d.deviceParameter}");
                                return Image.asset(d.icon, package: 'artemis_cupps', width: 40, height: 40);
                              }),
                            ],
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                Text("ACPS",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                Divider(),
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: MyFieldPicker<ParameterValue>(
                        label: "Airline",
                        required: true,
                        placeholder: "Airline",
                        searchAutoFocus: true,
                        headerBgColor: Color(0xffECECEC),
                        bodyBgColor: Color(0xffE9E9E9).withOpacity(0.48),

                        items: BasicClass.constData.data.carrier,
                        value: airline,
                        // prefixIcon: airlineLogoBuild(seg.operatingCarrier),
                        valueToString: (a) => a.code,
                        onChange: (a) {
                          airline = a;
                          setState((){});
                        },
                      ),
                    ),
                    Expanded(
                      child: MyFieldPicker<Airport>(
                        required: true,
                        searchAutoFocus: true,
                        label: "From",
                        placeholder: "City",
                        headerBgColor: Color(0xffECECEC),
                        bodyBgColor: Color(0xffE9E9E9).withOpacity(0.48),
                        valueToString: (dynamic a) => "$a",
                        itemToWidget: (dynamic a) => Text("$a (${(a as Airport).code3})"),
                        searchBuilder: (dynamic a) => "$a ${(a as Airport).name}",
                        items: BasicClass.constData.data.airport,
                        value: BasicClass.constData.data.airport.firstWhereOrNull((a) => a.code3 == airport?.code3),
                        onChange: (a) {
                          airport = a;
                          setState((){});
                        },
                      ),
                    ),
                    MyButton(label: "Connect",
                        disabled: airport == null && airline == null,
                        onPressed: (){
                          myCuppsController.initAcps(airport!.code3,airline!.code);
                        }),
                    Expanded(flex:2,child: Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      final acps = ref.watch(acpsProvider);
                      if(acps == null){
                        return SizedBox();
                      }
                      return acps.getGeneralWidget();
                    },))

                  ],),

              ],
            ),
          ),

        ],
      ),
    );
  }
}

class CuppsAppBar extends StatelessWidget implements PreferredSizeWidget {
  static CuppsController myCuppsController = getIt<CuppsController>();

  const CuppsAppBar({super.key});

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
                      Text("Cupps", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
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
