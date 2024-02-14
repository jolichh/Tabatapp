import "dart:async";
import "package:flutter/material.dart";
import "package:tabatapp/music/audio.dart";

class CountdownProvider extends ChangeNotifier {
  Duration duration =
      const Duration(seconds: 5); // Initial duration for work cycle
  int currentCycle = 1;
  final int totalCycles = 4;
  bool isRunning = false;
  StreamSubscription<int>? _streamSubscription;

  bool isWorkCycle = true;
  int cycleDuration = 0;
  int workDuration = 5;
  int breakDuration = 3;

  // Events to signal cycle transition
  final StreamController<int> _workCycleFinished = StreamController<int>();
  final StreamController<int> _breakCycleFinished = StreamController<int>();

  final audioPlayer = myAudioPlayer();

  // Getters for cycle events
  Stream<int> get workCycleFinished => _workCycleFinished.stream;
  Stream<int> get breakCycleFinished => _breakCycleFinished.stream;

  CountdownProvider() {
    cycleDuration = workDuration;
    duration = const Duration(seconds: 5);
  }

  void startStopTimer() {
    if (!isRunning) {
      _startTimer(cycleDuration);
      (isWorkCycle) ? audioPlayer.playAudio() : audioPlayer.breakAudio();
    } else if (_streamSubscription?.isPaused ?? false) {
      // Reanuda el temporizador y el audio

      _streamSubscription?.resume();
      audioPlayer.resumeAudio();
      isRunning = true;
    } else {
      // Pausa el audio si el temporizador se detiene
      isRunning = false;
      _streamSubscription?.pause();
      audioPlayer.pauseAudio();
    }
    notifyListeners();
  }

  void _startTimer(int seconds) {
    isRunning = true;
    _streamSubscription?.cancel();
    _streamSubscription = Stream<int>.periodic(
            const Duration(seconds: 1), (sec) => seconds - sec - 1)
        .take(seconds)
        .listen((timeLeftInSeconds) {
      duration = Duration(seconds: timeLeftInSeconds); // Actualiza la duración
      notifyListeners();
      if (timeLeftInSeconds == 0) {
        _handleCycleEnd();
      }
    });
    notifyListeners();
  }

  void stopTimer() {
    _streamSubscription?.pause();
    isRunning = isRunning;
    audioPlayer.pauseAudio();
    notifyListeners();
  }

  void setCountDownDuration(Duration newDuration) {
    duration = newDuration;
    _streamSubscription?.cancel();
    //isRunning = false;
    notifyListeners();
  }

  void _handleCycleEnd() {
    if (isWorkCycle) {
      _workCycleFinished.add(currentCycle);
      isWorkCycle = false;
      cycleDuration = breakDuration;
      duration = Duration(seconds: breakDuration);
      _startTimer(breakDuration);
      audioPlayer.breakAudio();
    } else {
      _breakCycleFinished.add(currentCycle);
      currentCycle++;
      if (currentCycle <= totalCycles) {
        isWorkCycle = true;
        cycleDuration = workDuration;
        duration = Duration(seconds: workDuration);
        _startTimer(workDuration);
        audioPlayer.playAudio();
      } else {
        isRunning = false;
        audioPlayer.pauseAudio();
        currentCycle = totalCycles;
      }
    }
  }

  void resetTimer() {
    currentCycle = 1;
    duration = Duration(seconds: workDuration);
    isRunning = false;
    _streamSubscription?.cancel();
    audioPlayer.pauseAudio();
    notifyListeners();
  }

  String get cycleLeftString {
    final ciclo = currentCycle.toString();
    return 'Cicle # $ciclo / 4';
  }

  String get timeLeftString {
    final seconds =
        (duration.inSeconds % 60).floor().toString().padLeft(2, '0');
    return '$seconds seg';
  }
}
