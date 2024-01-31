import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabata',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 58, 183, 87)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Tabata'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
  AudioPlayer audioPlayer = AudioPlayer();

  void _playAudio() {
    audioPlayer.play(DeviceFileSource('./assets/zyzz.mp3'));
  }

  void _breakAudio() {
    audioPlayer.play(DeviceFileSource('./assets/break.mp3'));
  }

  void _pauseAudio() {
    audioPlayer.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Cicle #1/4',
              //'$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              '5',
              //'$_counter',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: _playAudio,
                  tooltip: 'Play',
                  child: const Icon(Icons.play_arrow),
                ),
                FloatingActionButton(
                  onPressed: _pauseAudio,
                  tooltip: 'Play',
                  child: const Icon(Icons.pause),
                ),
                FloatingActionButton(
                  onPressed: _breakAudio,
                  tooltip: 'Play',
                  child: const Icon(Icons.repeat_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
