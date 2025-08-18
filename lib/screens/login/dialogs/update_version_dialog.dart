import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:tree_navigation/tree_navigation.dart';
import '../../../core/classes/new_version_class.dart';
import '../../../core/classes/version_check_class.dart';
import '../../../core/constants/ui.dart';
import '../../../core/navigation/navigation_service.dart';
import '../../../initialize.dart';
import '../login_controller.dart';

class UpdateVersionDialog extends StatelessWidget {
  final LoginController myLoginController = getIt<LoginController>();

  // final NavigationService navigationService = getIt<NavigationService>();
  final navigationService = GetIt.instance<NavigationInterface>();
  final VersionCheck versionCheck;

  UpdateVersionDialog({super.key, required this.versionCheck});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return CupertinoAlertDialog(
      title: const Text("Update"),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("New Version is Available"),
            Divider(
              color: MyColors.black3,
              height: 12,
            ),
            Text("${versionCheck.message}"),
            // newVersion.newFeatures.where((element) => element.isNotEmpty).isEmpty?SizedBox():Divider(color: MyColors.black3,height: 12,),
            // Text("${newVersion.newFeatures.map((e) => e).join("\n")}"),
            // MyAnimatedSwitcher(
            //     value: loginState.updateProgress == null,
            //     firstChild: const SizedBox(),
            //     secondChild: Padding(
            //       padding: const EdgeInsets.only(top: 12.0),
            //       child: Row(
            //         children: [
            //           Expanded(
            //               child: SizedBox(
            //                   height: 15,
            //                   child: FAProgressBar(
            //                     borderRadius: BorderRadius.circular(5),
            //                     displayTextStyle: const TextStyle(
            //                       color: Colors.black87,
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //                     progressColor: const Color(0xff33e848),
            //                     currentValue: (loginState.updateProgress ?? 0) * 100,
            //                     displayText: null,
            //                     backgroundColor: Colors.white,
            //                   ))),
            //           const SizedBox(width: 12),
            //           Text(
            //             ((loginState.updateProgress ?? 0) * 100).toStringAsFixed(2).padLeft(5, "0") + " %",
            //             style: GoogleFonts.robotoMono(),
            //           )
            //         ],
            //       ),
            //     ))
          ],
        ),
      ),
      // actions: loginState.updateProgress != null
      actions: false
          ? [
              CupertinoDialogAction(
                  onPressed: () {},
                  child: const SpinKitChasingDots(
                    color: Colors.blueAccent,
                    size: 25,
                  )),
            ]
          : versionCheck.isForce
              ? [
                  CupertinoDialogAction(
                      onPressed: () {
                        Navigator.of(context).pop(1);
                      },
                      child: const Text("Update")),
                ]
              : [
                  CupertinoDialogAction(
                      onPressed: () {
                        Navigator.of(context).pop(1);
                      },
                      child: const Text("Update")),
                  CupertinoDialogAction(
                      onPressed: () {
                        Navigator.of(context).pop(0);
                      },
                      child: const Text("Ignore")),
                ],
    );
  }
}
