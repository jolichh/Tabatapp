import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/count_down_provider.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({super.key, required this.title});

  // Create AudioPlayer instance

  // Initial values
  final int totalRounds = 4;

  @override
  Widget build(BuildContext context) {
    final countdownProvider = Provider.of<CountdownProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Display cycle information
            Text(
              context.select(
                  (CountdownProvider countDown) => countDown.cycleLeftString),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              context.select(
                  (CountdownProvider countDown) => countDown.timeLeftString),
              style: const TextStyle(fontSize: 50),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Start/Stop button
                FloatingActionButton(
                  onPressed: () {
                    // Toggle timer and play corresponding audio
                    countdownProvider.startStopTimer();
                  },
                  tooltip: 'Play',
                  child: Icon(
                    countdownProvider.isRunning
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                ),
                // Reset button
                FloatingActionButton(
                  onPressed: () {
                    countdownProvider.resetTimer();
                  },
                  tooltip: 'Reset',
                  child: const Icon(Icons.refresh),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
