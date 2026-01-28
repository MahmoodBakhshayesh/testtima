import 'dart:math';

import 'package:abds/core/constants/ui.dart';
import 'package:abds/core/utils_and_services/artemis_icons_icons.dart';
import 'package:abds/core/utils_and_services/stateControllers/segments_state_controller.dart';
import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:abds/widgets/AirlineLogo.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:abds/widgets/MyExpansionTile.dart';
import 'package:abds/widgets/MyFieldPicker.dart';
import 'package:abds/widgets/MyTextFieldNew.dart';
import 'package:abds/widgets/native_drop_down.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/classes/basic_class.dart';
import '../../../core/classes/constant_data_class.dart';
import '../../../core/extenstions/context_exp.dart';
import '../../../core/interfaces/local_data_base_int.dart';
import '../../../core/utils_and_services/country_flag_util.dart';
import '../../../core/utils_and_services/icomoon_layered_presets_from_css.dart';
import '../../../core/utils_and_services/operations/confirm_operation.dart';
import '../../../core/utils_and_services/stateControllers/passports_state_controller.dart';
import '../../../initialize.dart';
import '../../../widgets/DotButton.dart';
import '../../../widgets/DurationOfStayPicker.dart';
import '../../../widgets/MyDatePicker.dart';
import '../../../widgets/MySwitchButton.dart';
import '../../../widgets/MyTextField.dart';
import '../../../widgets/MyTimePicker.dart';
import '../home_controller.dart';
import '../home_state.dart';
import '../home_view_phone.dart';
import 'new_widgets_desktop/flight_widge_desktop_new.dart';
import 'new_widgets_desktop/passenger_widget_desktop_new.dart';
import 'new_widgets_desktop/passport_widget_desktop_new.dart';
import 'new_widgets_desktop/resident_widget_desktop_new.dart';
import 'new_widgets_desktop/visa_widget_desktop_new.dart';

class FlightPaxWidgetDesktop extends ConsumerStatefulWidget {
  const FlightPaxWidgetDesktop({super.key});

  @override
  ConsumerState<FlightPaxWidgetDesktop> createState() => _FlightPaxWidgetDesktopState();
}

class _FlightPaxWidgetDesktopState extends ConsumerState<FlightPaxWidgetDesktop> {
  @override
  Widget build(BuildContext context) {
    return MyExpansionTile(
      initiallyExpanded: true,
      controller: getIt<HomeController>().flightPaxExpandController,
      tilePadding: EdgeInsets.all(0),
      backgroundColor: Color(0xffD0DBFF).withOpacity(0.08),
      collapsedBackgroundColor: Color(0xffD0DBFF).withOpacity(0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12)),
      collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12)),
      showLeadingIcon: true,
      showFooter: false,
      title: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "Flight/Passenger",
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
      children: [
        FlightWidgetDesktop(),
        const SizedBox(height: 12),
        PaxWidgetDesktop(),
        const SizedBox(height: 12),
        PassportsWidgetDesktop(),
        const SizedBox(height: 12),
        VisasWidgetDesktop(),
        const SizedBox(height: 12),
        ResidentsWidgetDesktop(),
        AddManualDocumentDesktop(),
      ],
    );
  }
}

class AddManualDocumentDesktop extends StatelessWidget {
  const AddManualDocumentDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 100,
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(color: Color(0xffECE8E2), borderRadius: BorderRadius.circular(20)),
            child: Row(
              spacing: 12,
              children: [
                IcomoonLayeredCss.arrow_swap_horizontal(colors: [Color(0xffE58200).withOpacity(0.4), Color(0xffE58200), Color(0xffE58200), Colors.white], size: 40),
                Text(
                  "Swipe / Scan documents to load",
                  style: TextStyle(color: Color(0xffE58200), fontSize: 32, fontWeight: FontWeight.w200),
                ),
                Spacer(),
                MyButton(
                  label: "Manual Passport",
                  icon: ArtemisIcons.add_square,
                  reverse: true,
                  color: MyColors.mainBlue,
                  onPressed: () {
                    getIt<HomeController>().handleConfirming(DocumentDetail.passport());
                  },
                  borderSide: BorderSide(color: MyColors.mainBlue,),
                  radius: 12,
                ),
                MyButton(
                  label: "Manual Visa",
                  icon: ArtemisIcons.add_square,
                  reverse: true,
                  color: MyColors.mainBlue,
                  onPressed: () {
                    getIt<HomeController>().handleConfirming(DocumentDetail.visa());
                  },
                  borderSide: BorderSide(color: MyColors.mainBlue,),
                  radius: 12,
                ),
                MyButton(
                  label: "Manual Resident",
                  icon: ArtemisIcons.add_square,
                  reverse: true,
                  color: MyColors.mainBlue,
                  onPressed: () {
                    getIt<HomeController>().handleConfirming(DocumentDetail.resident());
                  },
                  borderSide: BorderSide(color: MyColors.mainBlue,),
                  radius: 12,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
