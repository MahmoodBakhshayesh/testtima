import 'dart:io';

import 'package:abds/core/constants/ui.dart';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/core/interfaces/success_int.dart';
import 'package:abds/core/utils_and_services/handlers/success_handler.dart';
import 'package:abds/core/utils_and_services/stateControllers/passports_state_controller.dart';
import 'package:abds/core/utils_and_services/stateControllers/segments_state_controller.dart';
import 'package:abds/core/utils_and_services/stateControllers/visas_state_controller.dart';
import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:abds/screens/home/home_state.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/classes/basic_class.dart';
import '../../../core/utils_and_services/artemis_icons_icons.dart';
import '../../../initialize.dart';
import '../../../widgets/DotButton.dart';
import '../../../widgets/MyDatePicker.dart';
import '../../../widgets/MyExpansionTile.dart';
import '../../../widgets/MyFieldPicker.dart';
import '../../../widgets/MyTextField.dart';
import '../home_controller.dart';
import '../home_view_phone.dart';

class AskSupervisorDialog extends StatefulWidget {
  final String logId;
  const AskSupervisorDialog({super.key,required this.logId});

  @override
  State<AskSupervisorDialog> createState() => _AskSupervisorDialogState();
}

class _AskSupervisorDialogState extends State<AskSupervisorDialog> {
  TextEditingController desC = TextEditingController();
  String? noteType;


  @override
  void dispose() {
    // ref.read(attachingPhotoPathProvider.notifier).update((s) => [...s.where((a) => a != p)]);

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
        insetPadding: EdgeInsets.symmetric(horizontal: 12),
        child: Container(
          width: double.infinity,

          decoration: BoxDecoration(color: MyColors.scaffoldBg, borderRadius: BorderRadiusGeometry.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    Expanded(child: Text("Ask Supervisor (${widget.logId})", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700))),CloseButton()],
                ),
              ),
              Divider(height: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                child: Row(
                  children: [
                    // Text("Please insert your reference code!"),
                    Expanded(
                      child: MyFieldPicker<String?>(
                        label: "Note Type",
                        items: BasicClass.constData.logNoteTypes,
                        value: noteType,
                        onChange: (a) {
                          noteType = a;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoTextField(
                  controller: desC,
                  placeholder: "Description",
                  decoration: BoxDecoration(color: Colors.white),
                  minLines: 5,
                  maxLines: 5,
                ),
              ),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0), child: PhotoAttachmentWidget()),
              const Divider(height: 12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyButton(
                  label: "Submit",
                  reverse: true,
                  borderSide: BorderSide(color: context.mainColor),
                  onPressed: () async {
                    final res = await getIt<HomeController>().uploadDataForSupervision(noteType,desC.text,widget.logId);
                    if(res){
                        Navigator.of(context).pop();
                        Future.delayed(Duration(milliseconds: 500),(){
                          SuccessHandler.handle(ServerSuccess(code: 1, msg: "Done"));
                        });
                    }else{

                    }
                    // Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PhotoAttachmentWidget extends ConsumerWidget {
  const PhotoAttachmentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photos = ref.watch(attachingPhotoPathProvider);
    return Container(
      margin: EdgeInsets.only(top: 12),
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        direction: Axis.horizontal,
        spacing: 8,
        runSpacing: 4,
        children: [
          MyButton(
            width: 75,
            height: 75,
            label: "Attach\nPhoto",
            // child: Text("Attach\nPhoto",textAlign: TextAlign.center,),
            onPressed: () {
              getIt<HomeController>().selectPhotoToAttachMethodDialog();
            },
            radius: 10,
          ),
          ...photos.map(
            (p) => SizedBox(
              width: 75,
              height: 75,
              child: Stack(
                children: [
                  SizedBox(
                    width: 75,
                    height: 75,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.file(File(p), fit: BoxFit.fill),
                    ),
                  ),
                  Positioned(
                    right: 2,
                    top: 2,
                    child: DotButton(
                      icon: Icons.delete,
                      color: Colors.red,
                      onPressed: () {
                        ref.read(attachingPhotoPathProvider.notifier).update((s) => [...s.where((a) => a != p)]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
