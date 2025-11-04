import 'package:abds/core/constants/ui.dart';
import 'package:abds/core/extenstions/context_exp.dart';
import 'package:abds/core/utils_and_services/stateControllers/passports_state_controller.dart';
import 'package:abds/core/utils_and_services/stateControllers/segments_state_controller.dart';
import 'package:abds/core/utils_and_services/stateControllers/visas_state_controller.dart';
import 'package:abds/core/utils_and_services/timatic/artemis_timatic.dart';
import 'package:abds/screens/home/home_state.dart';
import 'package:abds/widgets/MyButton.dart';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:voice_note_kit/voice_note_kit.dart';

import '../../../core/classes/basic_class.dart';
import '../../../core/utils_and_services/artemis_icons_icons.dart';
import '../../../initialize.dart';
import '../../../widgets/MyDatePicker.dart';
import '../../../widgets/MyExpansionTile.dart';
import '../../../widgets/MyFieldPicker.dart';
import '../../../widgets/MyTextField.dart';
import '../../login/login_state.dart';
import '../home_controller.dart';
import '../home_view_phone.dart';

class VoicePreviewDialog extends ConsumerStatefulWidget {
  final String address;

  const VoicePreviewDialog({super.key, required this.address});

  @override
  ConsumerState<VoicePreviewDialog> createState() => _VoicePreviewDialogState();
}

class _VoicePreviewDialogState extends ConsumerState<VoicePreviewDialog> {
  final player = AudioPlayer(); // Create a player
  bool init = false;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   final duration = player.setUrl("${ref.read(selectedServerProvider)!.apiAddress}/logs/attach/${widget.address}",  headers: {"Authorization": "Bearer ${ref.read(userProvider)!.token}"},).then((a){
    //     init = true;
    //
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
      insetPadding: EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text("Voice Overview", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  ),
                  CloseButton(),
                ],
              ),
            ),
            Divider(height: 1),
            const SizedBox(height: 12),
            Center(
              child: AudioPlayerWidget(
                autoPlay: false,
                autoLoad: true,
                audioPath: widget.address,
                audioType: AudioType.directFile,
                playerStyle: PlayerStyle.style1,
                size: 45,
                progressBarHeight: 5,
                backgroundColor: context.mainColor,
                progressBarColor: Colors.white,
                progressBarBackgroundColor: Colors.white,
                iconColor: Colors.white,
                shapeType: PlayIconShapeType.circular,
                showProgressBar: true,
                showTimer: true,
                width: 300,
                audioSpeeds: const [0.5, 1.0, 1.5, 2.0, 3.0],
              ),
            ),

            // ControlButtons(player),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyButton(
                label: "OK",
                reverse: true,
                borderSide: BorderSide(color: context.mainColor),
                onPressed: () async {
                  // player.play();
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Opens volume slider dialog
        // IconButton(
        //   icon: const Icon(Icons.volume_up),
        //   onPressed: () {
        //     // showSliderDialog(
        //     //   context: context,
        //     //   title: "Adjust volume",
        //     //   divisions: 10,
        //     //   min: 0.0,
        //     //   max: 1.0,
        //     //   value: player.volume,
        //     //   stream: player.volumeStream,
        //     //   onChanged: player.setVolume,
        //     // );
        //   },
        // ),

        /// This StreamBuilder rebuilds whenever the player state changes, which
        /// includes the playing/paused state and also the
        /// loading/buffering/ready state. Depending on the state we show the
        /// appropriate button or loading indicator.
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
              return Container(margin: const EdgeInsets.all(8.0), width: 64.0, height: 64.0, child: const CircularProgressIndicator());
            } else if (playing != true) {
              return IconButton(icon: const Icon(Icons.play_arrow), iconSize: 64.0, onPressed: player.play);
            } else if (processingState != ProcessingState.completed) {
              return IconButton(icon: const Icon(Icons.pause), iconSize: 64.0, onPressed: player.pause);
            } else {
              return IconButton(icon: const Icon(Icons.replay), iconSize: 64.0, onPressed: () => player.seek(Duration.zero));
            }
          },
        ),
        IconButton(icon: const Icon(Icons.stop), iconSize: 64.0, onPressed: player.stop),
        // Opens speed slider dialog
        // StreamBuilder<double>(
        //   stream: player.speedStream,
        //   builder: (context, snapshot) => IconButton(
        //     icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
        //         style: const TextStyle(fontWeight: FontWeight.bold)),
        //     onPressed: () {
        //       // showSliderDialog(
        //       //   context: context,
        //       //   title: "Adjust speed",
        //       //   divisions: 10,
        //       //   min: 0.5,
        //       //   max: 1.5,
        //       //   value: player.speed,
        //       //   stream: player.speedStream,
        //       //   onChanged: player.setSpeed,
        //       // );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
