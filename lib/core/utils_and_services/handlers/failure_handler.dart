import 'dart:developer';
import 'package:artemis_ui_kit/artemis_ui_kit.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tree_navigation/tree_navigation.dart';
import '../../../initialize.dart';
import '../../interfaces/failures_int.dart';

abstract class FailureHandler {
  static final navigationService = GetIt.instance<NavigationInterface>();
  static get context => navigationService.context;


  static void handle(Failure failure, {Function? retry}) {
    BotToast.showAttachedWidget(
        attachedBuilder: (_) => Transform.scale(
              scale: 0.9,
              child: Material(
                child: GestureDetector(
                  onTap: () {
                    BotToast.cleanAll();
                    // cancel();  //c
                  },
                  child: AbsorbPointer(
                    child: ArtemisAwesomeSnackbarContent(
                      title: 'Error!',
                      message: '$failure',
                      contentType: ContentType.failure,
                    ),
                  ),
                ),
              ),
            ),
        duration: const Duration(seconds: 10),
        target: const Offset(500, 30));
    // cancel();  //c
  }

  static void handle3(Failure failure, {Function? retry}) {
    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: ArtemisAwesomeSnackbarContent(
        title: 'Error!',
        message: '$failure',

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.failure,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showSnackBar(snackBar);
  }

  static void handle2(Failure failure, {Function? retry}) {
    if (failure is ValidationFailure) {
      navigationService.openSnackBar(SnackBar(content:  GestureDetector(onTap: () {}, child: Text("$failure")),
          margin: EdgeInsets.only(
            left: 12,
            bottom: 12,
            right: MediaQuery.of(navigationService.context).size.width * 0.5,
          ),
          backgroundColor: Colors.orangeAccent,
          duration: const Duration(seconds: 2)));
    } else {
      navigationService.openSnackBar(SnackBar(content:GestureDetector(onTap: () {}, child: Text("$failure")),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 10),
          margin: EdgeInsets.only(
            left: 12,
            bottom: 12,
            right: MediaQuery.of(navigationService.context).size.width * 0.7,
          ),
          action: SnackBarAction(
            textColor: Colors.white,
            label: "Retry",
            onPressed: () {
              log("Retry");
              retry?.call();
            },
          )));
    }
  }

  static void handleNoElement(String name) {
    navigationService.openSnackBar(
      SnackBar(content: Text("Could not Find $name"),
      backgroundColor: Colors.orange,
      duration: const Duration(seconds: 5),
    ));
  }
}

// class ArtemisAwesomeSnackbarContent extends StatelessWidget {
//   /// `IMPORTANT NOTE` for SnackBar properties before putting this in `content`
//   /// backgroundColor: Colors.transparent
//   /// behavior: SnackBarBehavior.floating
//   /// elevation: 0.0
//   /// /// `IMPORTANT NOTE` for MaterialBanner properties before putting this in `content`
//   /// backgroundColor: Colors.transparent
//   /// forceActionsBelow: true,
//   /// elevation: 0.0
//   /// [inMaterialBanner = true]
//   /// title is the header String that will show on top
//   final String title;
//
//   /// message String is the body message which shows only 2 lines at max
//   final String message;
//
//   /// `optional` color of the SnackBar/MaterialBanner body
//   final Color? color;
//
//   /// contentType will reflect the overall theme of SnackBar/MaterialBanner: failure, success, help, warning
//   final ContentType contentType;
//
//   /// if you want to use this in materialBanner
//   final bool inMaterialBanner;
//
//   const ArtemisAwesomeSnackbarContent({
//     Key? key,
//     this.color,
//     required this.title,
//     required this.message,
//     required this.contentType,
//     this.inMaterialBanner = false,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     bool isRTL = false;
//
//     final size = MediaQuery.of(context).size;
//
//     final loc = Localizations.maybeLocaleOf(context);
//     final localeLanguageCode = loc?.languageCode;
//
//
//     // screen dimensions
//     bool isMobile = size.width <= 768;
//     bool isTablet = size.width > 768 && size.width <= 992;
//     bool isDesktop = size.width >= 992;
//
//     /// for reflecting different color shades in the SnackBar
//     final hsl = HSLColor.fromColor(color ?? contentType.color!);
//     final hslDark = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0));
//
//     double horizontalPadding = 0.0;
//     double leftSpace = size.width * 0.12;
//     double rightSpace = size.width * 0.12;
//
//     if (isMobile) {
//       horizontalPadding = size.width * 0.01;
//     } else if (isTablet) {
//       leftSpace = size.width * 0.05;
//       horizontalPadding = size.width * 0.2;
//     } else {
//       leftSpace = size.width * 0.05;
//       horizontalPadding = size.width * 0.3;
//     }
//
//     return Container(
//       margin: EdgeInsets.symmetric(
//         horizontal: horizontalPadding,
//       ),
//       child: Stack(
//         clipBehavior: Clip.none,
//         alignment: Alignment.topCenter,
//         children: [
//           /// background container
//           Container(
//             width: size.width,
//             decoration: BoxDecoration(
//               color: color ?? contentType.color,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: IndexedStack(
//               index: 0,
//               children: [SizedBox(),
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: size.height * 0.02,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         /// `title` parameter
//                         Expanded(
//                           flex: 3,
//                           child: Text(
//                             title,
//                             style: TextStyle(
//                               fontSize: !isMobile
//                                   ? size.height * 0.03
//                                   : size.height * 0.025,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//
//                         InkWell(
//                           onTap: () {
//                             if (inMaterialBanner) {
//                               ScaffoldMessenger.of(context)
//                                   .hideCurrentMaterialBanner();
//                               return;
//                             }
//                             ScaffoldMessenger.of(context).hideCurrentSnackBar();
//                           },
//                           // child: SvgPicture.asset(
//                           //   AssetsPath.failure,
//                           //   height: size.height * 0.022,
//                           //   package: 'artemis_ui_kit',
//                           // ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: size.height * 0.005,
//                     ),
//
//                     /// `message` body text parameter
//                     Text(
//                       message,
//                       style: TextStyle(
//                         fontSize: size.height * 0.016,
//                         color: Colors.white,
//                       ),
//                     ),
//                     SizedBox(
//                       height: size.height * 0.015,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//
//           /// SVGs in body
//           SizedBox(
//             height: 100,
//             child: ClipRRect(
//               borderRadius: const BorderRadius.only(
//                 bottomLeft: Radius.circular(20),
//               ),
//               // child: SvgPicture.asset(
//               //   AssetsPath.bubbles,
//               //   height: size.height * 0.06,
//               //   width: size.width * 0.05,
//               //   color: hslDark.toColor(),
//               //   package: 'artemis_ui_kit',
//               // ),
//             ),
//           ),
//
//           Positioned(
//             top: -size.height * 0.02,
//             left: !isRTL
//                 ? leftSpace -
//                 (isMobile ? size.width * 0.075 : size.width * 0.035)
//                 : null,
//             right: isRTL
//                 ? rightSpace -
//                 (isMobile ? size.width * 0.075 : size.width * 0.035)
//                 : null,
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 // SvgPicture.asset(
//                 //   AssetsPath.back,
//                 //   height: size.height * 0.06,
//                 //   color: hslDark.toColor(),
//                 //   package: 'artemis_ui_kit',
//                 // ),
//                 // Positioned(
//                 //   top: size.height * 0.015,
//                 //   child: SvgPicture.asset(
//                 //     assetSVG(contentType),
//                 //     height: size.height * 0.022,
//                 //     package: 'artemis_ui_kit',
//                 //   ),
//                 // )
//               ],
//             ),
//           ),
//
//           /// content
//           Positioned.fill(
//             left: isRTL ? size.width * 0.03 : leftSpace,
//             right: isRTL ? rightSpace : size.width * 0.03,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: size.height * 0.02,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     /// `title` parameter
//                     Expanded(
//                       flex: 3,
//                       child: Text(
//                         title,
//                         style: TextStyle(
//                           fontSize: !isMobile
//                               ? size.height * 0.03
//                               : size.height * 0.025,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//
//                     InkWell(
//                       onTap: () {
//                         if (inMaterialBanner) {
//                           ScaffoldMessenger.of(context)
//                               .hideCurrentMaterialBanner();
//                           return;
//                         }
//                         ScaffoldMessenger.of(context).hideCurrentSnackBar();
//                       },
//                       child: SvgPicture.asset(
//                         AssetsPath.failure,
//                         height: size.height * 0.022,
//                         package: 'artemis_ui_kit',
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: size.height * 0.005,
//                 ),
//
//                 /// `message` body text parameter
//                 Expanded(
//                   child: SizedBox(
//                     height: 200,
//                     child: Text(
//                       message,
//                       style: TextStyle(
//                         fontSize: size.height * 0.016,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: size.height * 0.015,
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   /// Reflecting proper icon based on the contentType
//   String assetSVG(ContentType contentType) {
//     if (contentType == ContentType.failure) {
//       /// failure will show `CROSS`
//       return AssetsPath.failure;
//     } else if (contentType == ContentType.success) {
//       /// success will show `CHECK`
//       return AssetsPath.success;
//     } else if (contentType == ContentType.warning) {
//       /// warning will show `EXCLAMATION`
//       return AssetsPath.warning;
//     } else if (contentType == ContentType.help) {
//       /// help will show `QUESTION MARK`
//       return AssetsPath.help;
//     } else {
//       return AssetsPath.failure;
//     }
//   }
// }
//
// class ContentType {
//   /// message is `required` parameter
//   final String message;
//
//   /// color is optional, if provided null then `DefaultColors` will be used
//   final Color? color;
//
//   ContentType(this.message, [this.color]);
//
//   static ContentType help = ContentType('help', DefaultColors.helpBlue);
//   static ContentType failure = ContentType('failure', DefaultColors.failureRed);
//   static ContentType success =
//   ContentType('success', DefaultColors.successGreen);
//   static ContentType warning =
//   ContentType('warning', DefaultColors.warningYellow);
// }
//
// class AssetsPath {
//   static const String help = 'assets/images/types/help.svg';
//   static const String failure = 'assets/images/types/failure.svg';
//   static const String success = 'assets/images/types/success.svg';
//   static const String warning = 'assets/images/types/warning.svg';
//
//   static const String back = 'assets/images/back.svg';
//   static const String bubbles = 'assets/images/bubbles.svg';
// }
//
// class DefaultColors {
//   /// help
//   static const Color helpBlue = Color(0xff3282B8);
//
//   /// failure
//   static const Color failureRed = Color(0xffc72c41);
//
//   /// success
//   static const Color successGreen = Color(0xff2D6A4F);
//
//   /// warning
//   static const Color warningYellow = Color(0xffFCA652);
// }
