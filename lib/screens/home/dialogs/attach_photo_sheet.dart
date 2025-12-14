import 'dart:io';
import 'dart:developer' as dev;
import 'package:abds/core/classes/basic_class.dart';
import 'package:abds/core/classes/server_mrz_result_class.dart';
import 'package:abds/core/constants/ui.dart';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/core/utils_and_services/artemis_icons_icons.dart';
import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:abds/initialize.dart';
import 'package:abds/screens/home/dialogs/ask_supervisor_dialog.dart';
import 'package:abds/screens/home/home_controller.dart';
import 'package:abds/screens/home/home_state.dart';
import 'package:abds/screens/mrz_reader/mrz_reader_state.dart';
import 'package:abds/widgets/DotButton.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:abds/widgets/MyFieldPicker.dart';
import 'package:abds/widgets/MyTextField.dart';
import 'package:abds/widgets/drawer_action.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr_mrz/ocr_mrz_settings_class.dart';
import 'package:voice_note_kit/recorder/voice_enums/voice_enums.dart';
import 'package:voice_note_kit/voice_note_kit.dart';

import '../../../core/classes/mrz_agg_class.dart';
import '../../../core/interfaces/success_int.dart';
import '../../../core/utils_and_services/cross_helpers/adaptive_image_path.dart';
import '../../../core/utils_and_services/handlers/success_handler.dart';
import '../home_drawer.dart';

class AttachPhotoSheet extends StatefulWidget {
  final String logId;

  const AttachPhotoSheet({super.key, required this.logId});

  @override
  State<AttachPhotoSheet> createState() => _MyOcrSettingDialogState();
}

class _MyOcrSettingDialogState extends State<AttachPhotoSheet> {
  // String? attachingPhoto;
  List<String> attachingPhoto = [];

  @override
  Widget build(BuildContext context) {
    if(context.isDesktop){
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                const SizedBox(width: 12),
                Expanded(child: Text("Add Attachment")),
                CloseButton(),
              ],
            ),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              color: Colors.black.withOpacity(0.02),
              child: Column(
                spacing: 12,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    direction: Axis.horizontal,
                    runSpacing: 12,
                    spacing: 12,
                    children: attachingPhoto
                        .map(
                          (a) => ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(12),
                        child: Stack(
                          children: [
                            SizedBox(
                              width: (context.width - 48) / 3,
                              height: (context.width - 48) / 3,
                              // child: Image.file(key: Key(a), File(a), fit: BoxFit.fill),
                              child: AdaptiveImagePath(path: a,key: Key(a),fit: BoxFit.fill,),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: DotButton(
                                backgroundColor: Colors.white,
                                color: Colors.black,
                                icon: Icons.delete,
                                onPressed: () {
                                  attachingPhoto.remove(a);
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        .toList(),
                  ),
                  Column(
                    spacing: 12,
                    children: [
                      DrawerAction(
                        title: "Gallery",
                        onTap: () async {
                          final path = await getIt<HomeController>().selectPhotoToAttach(ImageSource.gallery);
                          if (path != null) {
                            attachingPhoto.add(path);
                            setState(() {});
                          }
                        },
                        leadingIcon: ArtemisIcons.camera,
                      ),
                      // DrawerAction(
                      //   title: "File",
                      //   onTap: () async {
                      //     final path = await getIt<HomeController>().selectPhotoToAttach(ImageSource.gallery);
                      //     if (path != null) {
                      //       attachingPhoto.add(path);
                      //       setState(() {});
                      //     }
                      //   },
                      //   leadingIcon: ArtemisIcons.attach_circle,
                      // ),


                      // Expanded(
                      //   child: MyButton(
                      //     height: (context.width - 36) / 2,
                      //     radius: 25,
                      //     // fade: true,
                      //     reverse: true,
                      //     borderSide: BorderSide(color: context.mainColor),
                      //     label: "",
                      //     onPressed: () async {
                      //       final path = await getIt<HomeController>().selectPhotoToAttach(ImageSource.camera);
                      //       if (path != null) {
                      //         attachingPhoto.add(path);
                      //         setState(() {});
                      //       }
                      //     },
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Icon(ArtemisIcons.camera, color: context.mainColor, size: 50),
                      //         Text("Camera", style: TextStyle(color: context.mainColor, fontSize: 14)),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // Expanded(
                      //   child: MyButton(
                      //     height: (context.width - 36) / 2,
                      //     radius: 25,
                      //     fade: true,
                      //     // reverse: true,
                      //     borderSide: BorderSide(color: context.mainColor),
                      //     label: "",
                      //     onPressed: () async {
                      //       final path = await getIt<HomeController>().selectPhotoToAttach(ImageSource.gallery);
                      //       if (path != null) {
                      //         attachingPhoto.add(path);
                      //         setState(() {});
                      //       }
                      //     },
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Icon(ArtemisIcons.attach_circle, color: context.mainColor, size: 50),
                      //         Text("Gallery", style: TextStyle(color: context.mainColor, fontSize: 14)),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  // Expanded(
                  //   child: Column(
                  //     spacing: 12,
                  //     children: [
                  //       Wrap(
                  //         direction: Axis.horizontal,
                  //         children: attachingPhoto.map((a)=>ClipRRect(
                  //         borderRadius: BorderRadiusGeometry.circular(12),
                  //         child: SizedBox(
                  //           width: 108,
                  //           height: 108,
                  //           child: Image.file(
                  //               key: Key(a),
                  //               File(a), fit: BoxFit.fill),
                  //         ),
                  //       )).toList(),),
                  //       Row(children: [
                  //         // Expanded(
                  //         //   child: MyButton(label: "",onPressed: (){},child: Column(children: [
                  //         //     Icon(ArtemisIcons.camera),
                  //         //     Text("Camera")
                  //         //   ],),),
                  //         // ),
                  //         // Expanded(
                  //         //   child: MyButton(label: "",onPressed: (){},child: Column(children: [
                  //         //     Icon(ArtemisIcons.camera),
                  //         //     Text("Camera")
                  //         //   ],),),
                  //         // ),
                  //       ],)
                  //       // Padding(
                  //       //   padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                  //       //   child: Container(
                  //       //     padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  //       //     decoration: BoxDecoration(
                  //       //       border: Border.all(color: MyColors.lineColor),
                  //       //       borderRadius: BorderRadiusGeometry.circular(10),
                  //       //     ),
                  //       //     height: context.width * 0.9,
                  //       //     width: context.width * 0.9,
                  //       //     child: ClipRRect(
                  //       //       borderRadius: BorderRadius.circular(8),
                  //       //       child: attachingPhoto == null
                  //       //           ? DotButton(
                  //       //               icon: Icons.attach_file,
                  //       //               size: 200,
                  //       //               onPressed: () async {
                  //       //                 final path = await getIt<HomeController>().selectPhotoToAttachMethodDialog();
                  //       //                 if (path != null) {
                  //       //                   attachingPhoto = path;
                  //       //                   setState(() {});
                  //       //                 }
                  //       //               },
                  //       //             )
                  //       //           : Stack(
                  //       //               children: [
                  //       //                 SizedBox(
                  //       //
                  //       //                   height: context.width * 0.9,
                  //       //                   width: context.width * 0.9,
                  //       //                   child: Image.file(File(attachingPhoto!), fit: BoxFit.fill),
                  //       //                 ),
                  //       //                 Positioned(
                  //       //                   right: 12,
                  //       //                   top: 12,
                  //       //                   child: DotButton(icon: Icons.delete, color: Colors.red, onPressed: () {
                  //       //                     attachingPhoto = null;
                  //       //                     setState((){});
                  //       //                   }, size: 55),
                  //       //                 ),
                  //       //               ],
                  //       //             ),
                  //       //     ),
                  //       //   ),
                  //       // ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: MyButton(
                      color: Colors.grey,
                      borderSide: BorderSide(color: MyColors.lineColor),
                      reverse: true,
                      radius: 12,
                      label: "Cancel",
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MyButton(
                      label: "Attach",
                      icon: ArtemisIcons.attach_circle,
                      iconInRight: true,
                      radius: 12,
                      onPressed: attachingPhoto.isEmpty
                          ? null
                          : () async {
                        final bool = await getIt<HomeController>().attachToResult(logId: widget.logId, images: attachingPhoto, voices: [], data: {"action": "attachPhoto"});
                        if (bool) {
                          Navigator.of(context).pop(true);
                          Future.delayed(Duration(milliseconds: 300), () {
                            SuccessHandler.handle(ServerSuccess(code: 1, msg: "Done"));
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return SafeArea(
      bottom: true,
      child: Container(
        constraints: BoxConstraints(maxHeight: (context.height * 0.9)),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // pushes above keyboard
        ),
        // height: context.height*0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                const SizedBox(width: 12),
                Expanded(child: Text("Add Attachment")),
                CloseButton(),
              ],
            ),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              color: Colors.black.withOpacity(0.02),
              child: Column(
                spacing: 12,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    direction: Axis.horizontal,
                    runSpacing: 12,
                    spacing: 12,
                    children: attachingPhoto
                        .map(
                          (a) => ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(12),
                            child: Stack(
                              children: [
                                SizedBox(
                                  width: (context.width - 48) / 3,
                                  height: (context.width - 48) / 3,
                                  child: Image.file(key: Key(a), File(a), fit: BoxFit.fill),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: DotButton(
                                    backgroundColor: Colors.white,
                                    color: Colors.black,
                                    icon: Icons.delete,
                                    onPressed: () {
                                      attachingPhoto.remove(a);
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  Column(
                    spacing: 12,
                    children: [
                      DrawerAction(
                        title: "Camera",
                        onTap: () async {
                          final path = await getIt<HomeController>().selectPhotoToAttach(ImageSource.camera);
                          if (path != null) {
                            attachingPhoto.add(path);
                            setState(() {});
                          }
                        },
                        leadingIcon: ArtemisIcons.camera,
                      ),
                      // DrawerAction(
                      //   title: "File",
                      //   onTap: () async {
                      //     final path = await getIt<HomeController>().selectPhotoToAttach(ImageSource.gallery);
                      //     if (path != null) {
                      //       attachingPhoto.add(path);
                      //       setState(() {});
                      //     }
                      //   },
                      //   leadingIcon: ArtemisIcons.attach_circle,
                      // ),


                      // Expanded(
                      //   child: MyButton(
                      //     height: (context.width - 36) / 2,
                      //     radius: 25,
                      //     // fade: true,
                      //     reverse: true,
                      //     borderSide: BorderSide(color: context.mainColor),
                      //     label: "",
                      //     onPressed: () async {
                      //       final path = await getIt<HomeController>().selectPhotoToAttach(ImageSource.camera);
                      //       if (path != null) {
                      //         attachingPhoto.add(path);
                      //         setState(() {});
                      //       }
                      //     },
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Icon(ArtemisIcons.camera, color: context.mainColor, size: 50),
                      //         Text("Camera", style: TextStyle(color: context.mainColor, fontSize: 14)),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // Expanded(
                      //   child: MyButton(
                      //     height: (context.width - 36) / 2,
                      //     radius: 25,
                      //     fade: true,
                      //     // reverse: true,
                      //     borderSide: BorderSide(color: context.mainColor),
                      //     label: "",
                      //     onPressed: () async {
                      //       final path = await getIt<HomeController>().selectPhotoToAttach(ImageSource.gallery);
                      //       if (path != null) {
                      //         attachingPhoto.add(path);
                      //         setState(() {});
                      //       }
                      //     },
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Icon(ArtemisIcons.attach_circle, color: context.mainColor, size: 50),
                      //         Text("Gallery", style: TextStyle(color: context.mainColor, fontSize: 14)),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  // Expanded(
                  //   child: Column(
                  //     spacing: 12,
                  //     children: [
                  //       Wrap(
                  //         direction: Axis.horizontal,
                  //         children: attachingPhoto.map((a)=>ClipRRect(
                  //         borderRadius: BorderRadiusGeometry.circular(12),
                  //         child: SizedBox(
                  //           width: 108,
                  //           height: 108,
                  //           child: Image.file(
                  //               key: Key(a),
                  //               File(a), fit: BoxFit.fill),
                  //         ),
                  //       )).toList(),),
                  //       Row(children: [
                  //         // Expanded(
                  //         //   child: MyButton(label: "",onPressed: (){},child: Column(children: [
                  //         //     Icon(ArtemisIcons.camera),
                  //         //     Text("Camera")
                  //         //   ],),),
                  //         // ),
                  //         // Expanded(
                  //         //   child: MyButton(label: "",onPressed: (){},child: Column(children: [
                  //         //     Icon(ArtemisIcons.camera),
                  //         //     Text("Camera")
                  //         //   ],),),
                  //         // ),
                  //       ],)
                  //       // Padding(
                  //       //   padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                  //       //   child: Container(
                  //       //     padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  //       //     decoration: BoxDecoration(
                  //       //       border: Border.all(color: MyColors.lineColor),
                  //       //       borderRadius: BorderRadiusGeometry.circular(10),
                  //       //     ),
                  //       //     height: context.width * 0.9,
                  //       //     width: context.width * 0.9,
                  //       //     child: ClipRRect(
                  //       //       borderRadius: BorderRadius.circular(8),
                  //       //       child: attachingPhoto == null
                  //       //           ? DotButton(
                  //       //               icon: Icons.attach_file,
                  //       //               size: 200,
                  //       //               onPressed: () async {
                  //       //                 final path = await getIt<HomeController>().selectPhotoToAttachMethodDialog();
                  //       //                 if (path != null) {
                  //       //                   attachingPhoto = path;
                  //       //                   setState(() {});
                  //       //                 }
                  //       //               },
                  //       //             )
                  //       //           : Stack(
                  //       //               children: [
                  //       //                 SizedBox(
                  //       //
                  //       //                   height: context.width * 0.9,
                  //       //                   width: context.width * 0.9,
                  //       //                   child: Image.file(File(attachingPhoto!), fit: BoxFit.fill),
                  //       //                 ),
                  //       //                 Positioned(
                  //       //                   right: 12,
                  //       //                   top: 12,
                  //       //                   child: DotButton(icon: Icons.delete, color: Colors.red, onPressed: () {
                  //       //                     attachingPhoto = null;
                  //       //                     setState((){});
                  //       //                   }, size: 55),
                  //       //                 ),
                  //       //               ],
                  //       //             ),
                  //       //     ),
                  //       //   ),
                  //       // ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: MyButton(
                      color: Colors.grey,
                      borderSide: BorderSide(color: MyColors.lineColor),
                      reverse: true,
                      radius: 12,
                      label: "Cancel",
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MyButton(
                      label: "Attach",
                      icon: ArtemisIcons.attach_circle,
                      iconInRight: true,
                      radius: 12,
                      onPressed: attachingPhoto.isEmpty
                          ? null
                          : () async {
                              final bool = await getIt<HomeController>().attachToResult(logId: widget.logId, images: attachingPhoto, voices: [], data: {"action": "attachPhoto"});
                              if (bool) {
                                Navigator.of(context).pop(true);
                                Future.delayed(Duration(milliseconds: 300), () {
                                  SuccessHandler.handle(ServerSuccess(code: 1, msg: "Done"));
                                });
                              }
                            },
                    ),
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
