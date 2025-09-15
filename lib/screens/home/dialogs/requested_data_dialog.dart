import 'package:abds/core/constants/ui.dart';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/core/utils_and_services/stateControllers/passports_state_controller.dart';
import 'package:abds/core/utils_and_services/stateControllers/segments_state_controller.dart';
import 'package:abds/core/utils_and_services/stateControllers/visas_state_controller.dart';
import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:abds/screens/home/home_state.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RequestedDataDialog extends ConsumerWidget {
  const RequestedDataDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PassengerDetails passengerDetails = ref.watch(passengerProvider);
    List<ItinerarySegment> segments = ref.watch(segmentsProvider);
    List<DocumentDetail> passports = ref.watch(passportsProvider);
    // List<DocumentDetail> visas = ref.watch(visasProvider);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
      insetPadding: EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("FLIGHT INFO", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        Column(
                          children: segments
                              .map(
                                (seg) => Row(
                                  spacing: 12,
                                  children: [
                                    Expanded(
                                      child: FiledInfoWidget(label: "FROM", value: seg.departure.point.toString()),
                                    ),
                                    Expanded(
                                      child: FiledInfoWidget(label: "TO", value: seg.arrival.point.toString()),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("PASSENGER", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        Row(
                          spacing: 12,
                          children: [
                            Expanded(
                              child: FiledInfoWidget(label: "NATIONALITY", value: passengerDetails.nationality?.code3 ?? ''),
                            ),
                            Expanded(
                              child: FiledInfoWidget(label: "RESIDENT", value: passengerDetails.residentCountryCode?.code3 ?? ''),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("PASSPORT", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        Column(
                          children: passports
                              .map(
                                (pass) => Column(
                                  children: [
                                    Row(
                                      spacing: 12,
                                      children: [
                                        Expanded(
                                          child: FiledInfoWidget(label: "CODE", value: pass.documentCode?.code),
                                        ),
                                        Expanded(
                                          child: FiledInfoWidget(label: "TO", value: pass.documentIssueCountry?.code3),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      spacing: 12,
                                      children: [
                                        Expanded(
                                          child: FiledInfoWidget(label: "Expiry", value: pass.documentExpiryDate?.format_ddMMMEEE),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text("VISA", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    //     const SizedBox(height: 12),
                    //     Column(
                    //       children: visas
                    //           .map(
                    //             (visa) => Column(
                    //               spacing: 12,
                    //               children: [
                    //                 Row(
                    //                   spacing: 12,
                    //                   children: [
                    //                     Expanded(
                    //                       child: FiledInfoWidget(label: "ISSUING", value: visa.documentIssueCountry?.code3),
                    //                     ),
                    //                     Expanded(
                    //                       child: FiledInfoWidget(label: "Expiry", value: visa.documentExpiryDate?.format_ddMMMEEE),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 Row(
                    //                   spacing: 12,
                    //                   children: [
                    //                     Expanded(
                    //                       child: FiledInfoWidget(label: "CODE", value: visa.documentCode?.code),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ],
                    //             ),
                    //           )
                    //           .toList(),
                    //     ),
                    //     const SizedBox(height: 16),
                    //   ],
                    // ),
                  ],
                ),
              ),
              MyButton(
                label: "OK",
                reverse: true,
                borderSide: BorderSide(color: context.mainColor),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FiledInfoWidget extends StatelessWidget {
  final String label;
  final String? value;

  const FiledInfoWidget({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(10),
        border: Border.all(color: MyColors.lineColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
          Text(value ?? '', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        ],
      ),
    );
  }
}

class BriefFiledInfoWidget extends StatelessWidget {
  final String label;
  final String? value;

  const BriefFiledInfoWidget({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(5),
        border: Border.all(color: MyColors.lineColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
          Text(value ?? '', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
        ],
      ),
    );
  }
}
