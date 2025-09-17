import 'package:flutter/material.dart';
import 'package:voice_note_kit/player/audio_player_widget.dart';
import 'package:voice_note_kit/player/player_enums/player_enums.dart';
import 'package:voice_note_kit/player/utils/format_duration.dart';
import 'package:voice_note_kit/player/widgets/custom_slider.dart';
import 'package:voice_note_kit/player/widgets/custom_speed_button.dart';

import 'my_player.dart';

/// A widget that represents the default player style.
class MyPlayerWidget extends StatelessWidget {
  /// Creates a new instance of the [MyPlayerWidget] class.
  final MyAudioPlayerWidget widget;

  /// The current state of the audio player.
  final bool isPlaying;

  /// The progress of the audio player.
  final double progress;

  /// The current position of the audio player.
  final Duration position;

  /// The duration of the audio player.
  final Duration duration;

  /// Whether to show the progress bar or not.
  final bool showProgressBar;

  /// Whether to show the timer or not.
  final bool showTimer;

  /// The function to play the audio.
  final Function playAudio;

  /// The function to pause the audio.
  final Function pauseAudio;

  /// The function to seek to a specific position in the audio.
  final Function(double) seekTo;

  /// Whether to show the speed control or not
  final bool showSpeedControl; // New property
  /// The available playback speeds
  final List<double> playbackSpeeds; // New property

  /// The current playback speed
  final double currentSpeed;

  /// The function to set the playback speed
  final Function(double) setSpeed;

  /// Creates a new instance of the [MyPlayerWidget] class.
  const MyPlayerWidget(
      {super.key,
        required this.widget,
        required this.isPlaying,
        required this.progress,
        required this.position,
        required this.duration,
        required this.showProgressBar,
        required this.showTimer,
        required this.playAudio,
        required this.pauseAudio,
        required this.seekTo,
        required this.showSpeedControl,
        required this.playbackSpeeds,
        required this.currentSpeed,
        required this.setSpeed});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: widget.textDirection,
      child: Container(
        width: widget.width,
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            _CircleButton(
              color: Colors.green,
              icon: isPlaying ? Icons.pause : Icons.play_arrow,
              onTap: () {
                if (isPlaying) {
                  pauseAudio();
                } else {
                  playAudio();
                }
              },
            ),
            // GestureDetector(
            //   onTap: () {
            //     if (isPlaying) {
            //       pauseAudio();
            //     } else {
            //       playAudio();
            //     }
            //   },
            //   child: Container(
            //     width: widget.size,
            //     height: widget.size,
            //     decoration: BoxDecoration(
            //       shape: widget.shapeType == PlayIconShapeType.circular
            //           ? BoxShape.circle
            //           : widget.shapeType == PlayIconShapeType.roundedRectangle
            //           ? BoxShape.rectangle
            //           : BoxShape.rectangle,
            //       borderRadius:
            //       widget.shapeType == PlayIconShapeType.roundedRectangle
            //           ? BorderRadius.circular(8.0)
            //           : null,
            //       color: widget.iconColor.withAlpha((0.2 * 255).round()),
            //     ),
            //     child: RotatedBox(
            //       quarterTurns:
            //       widget.textDirection == TextDirection.ltr ? 0 : 2,
            //       child: Icon(
            //         isPlaying ? Icons.pause : Icons.play_arrow,
            //         color: widget.iconColor,
            //         size: widget.size * 0.6,
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(width: 24.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // if (showTimer)
                  //   Text(
                  //     formatDuration(position),
                  //     style: widget.timerTextStyle ??
                  //         TextStyle(
                  //           color: widget.iconColor,
                  //           fontSize: 14,
                  //         ),
                  //   ),
                  if (showProgressBar)
                    CustomSlider(
                      progress: progress,
                      progressBarColor: widget.progressBarColor,
                      progressBarBackgroundColor:
                      widget.progressBarBackgroundColor,
                      seekTo: seekTo,
                    ),
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            if (showTimer) ...[
              Text(
                formatDuration(duration),
                style: widget.timerTextStyle ??
                    TextStyle(
                      color: widget.iconColor,
                      fontSize: 14,
                    ),
              ),
            ],
            if (showSpeedControl) ...[
              const SizedBox(width: 8.0),
              SpeedButton(
                currentSpeed: currentSpeed,
                playbackSpeeds: playbackSpeeds,
                setSpeed: setSpeed,
                iconColor: widget.iconColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}


class _CircleButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback? onTap;

  const _CircleButton({
    required this.color,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3)),
          ],
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
            child: Icon(icon, key: ValueKey(icon), color: Colors.white, size: 25),
          ),
        ),
      ),
    );
  }
}