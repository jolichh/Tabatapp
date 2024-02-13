import 'package:audioplayers/audioplayers.dart';

// ignore: camel_case_types
class myAudioPlayer extends AudioPlayer {
  final audioPlayer = AudioPlayer();
  bool isPaused = false;

  void playAudio() {
    audioPlayer.play(DeviceFileSource('./assets/zyzz.mp3'));
  }

  void breakAudio() {
    audioPlayer.play(DeviceFileSource('./assets/break.mp3'));
  }

  void pauseAudio() {
    audioPlayer.pause();
    isPaused = true;
  }

  void resumeAudio() {
    if (isPaused) {
      audioPlayer.resume();
      isPaused = false;
    }
  }
}
