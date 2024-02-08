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
  final CountdownController _controller = CountdownController();
  AudioPlayer audioPlayer = AudioPlayer();

  int cicle = 0;
  int hiit = 4;
  int rest = 3;
  int s = 7; // total segundos
  Timer? timer;

  void start() {
    cicle = 1;
    _cicleTimer();
  }

  void _cicleTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        s--;

        if (s == 0) {
          if (cicle % 2 == 1) {
            // Tiempo de trabajo
            _playAudio();
            s = 4; // Cambiar a 4 segundos para el próximo ciclo
          } else {
            // Tiempo de descanso
            _breakAudio();
            s = 3; // Cambiar a 3 segundos para el próximo ciclo
          }

          cicle++;

          if (cicle > 3) {
            timer
                .cancel(); // Detener después de 4 ciclos (4 ciclos de trabajo + 4 ciclos de descanso)
          }
        }
      });
    });
  }

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
              'Cicle #$cicle/4',
              //'$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              '$s',
              //'$_counter',
              style: const TextStyle(
                fontSize: 100,
              ),
            ),
            /*Countdown(
                // controller: _controller,
                seconds: 5,
                build: (_, double time) => Text(
                      time.toString(),
                      style: const TextStyle(
                        fontSize: 100,
                      ),
                    ),
                interval: Duration(milliseconds: 100),
                onFinished: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Finish!'),
                    ),
                  );
                }),*/
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    start();
                  },
                  tooltip: 'Play',
                  child: const Icon(Icons.timer),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}