import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const NightOwlApp());
}

class NightOwlApp extends StatelessWidget {
  const NightOwlApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NightOwl Timer',
      home: NightOwlHome(),
    );
  }
}

class NightOwlHome extends StatefulWidget {
  const NightOwlHome({super.key});

  @override
  State<NightOwlHome> createState() => _NightOwlHomeState();
}

class _NightOwlHomeState extends State<NightOwlHome> {
  int seconds = 0;
  Timer? timer;
  List<String> laps = [];

  // Start timer
  void startTimer() {
    if (timer != null && timer!.isActive) return; // Already running
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        seconds++;
      });
    });
  }

  // Stop timer
  void stopTimer() {
    timer?.cancel();
  }

  // Reset timer
  void resetTimer() {
    timer?.cancel();
    setState(() {
      seconds = 0;
      laps.clear();
    });
  }

  // Add lap
  void addLap() {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    final hours = minutes ~/ 60;
    final displayMinutes = minutes % 60;
    final lapTime =
        "${hours.toString().padLeft(2, '0')}:${displayMinutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
    setState(() {
      laps.insert(0, lapTime);
    });
  }

  // Format timer display
  String get timerText {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    final hours = minutes ~/ 60;
    final displayMinutes = minutes % 60;
    return "${hours.toString().padLeft(2, '0')}:${displayMinutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/img.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Timer + Buttons
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Timer Text
              Text(
                timerText,
                style: const TextStyle(
                  fontSize: 60,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 8,
                      color: Colors.black45,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Start Button
                  ElevatedButton(
                    onPressed: startTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.tealAccent.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 15),
                    ),
                    child: const Text('Start'),
                  ),
                  const SizedBox(width: 15),

                  // Stop Button
                  ElevatedButton(
                    onPressed: stopTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 15),
                    ),
                    child: const Text('Stop'),
                  ),
                  const SizedBox(width: 15),

                  // Lap Button
                  ElevatedButton(
                    onPressed: addLap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 15),
                    ),
                    child: const Text('Lap'),
                  ),
                  const SizedBox(width: 15),

                  // Reset Button
                  ElevatedButton(
                    onPressed: resetTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 15),
                    ),
                    child: const Text('Reset'),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Lap List
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ListView.builder(
                    itemCount: laps.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          laps[index],
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            shadows: [
                              Shadow(
                                blurRadius: 4,
                                color: Colors.black45,
                                offset: Offset(1, 1),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
