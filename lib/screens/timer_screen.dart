import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/pastel_button.dart';

class TimerScreen extends StatefulWidget {
  final String background;
  const TimerScreen({super.key, required this.background});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int seconds = 0;
  Timer? timer;
  List<String> laps = [];

  void startTimer() {
    if (timer != null && timer!.isActive) return;
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => seconds++);
    });
  }

  void stopTimer() => timer?.cancel();

  void resetTimer() {
    timer?.cancel();
    setState(() {
      seconds = 0;
      laps.clear();
    });
  }

  void addLap() {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = seconds % 60;

    laps.insert(
      0,
      "${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}",
    );
    setState(() {});
  }

  String get timerText {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = seconds % 60;
    return "${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(widget.background, fit: BoxFit.cover),
        ),
        Column(
          children: [
            const SizedBox(height: 120),
            Text(
              timerText,
              style: const TextStyle(
                fontSize: 60,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(blurRadius: 8, color: Colors.black45, offset: Offset(2, 2)),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Wrap(
              spacing: 12,
              children: [
                pastelButton("Start", startTimer, const Color(0xFFD8F3DC)),
                pastelButton("Stop", stopTimer, const Color(0xFFFFE5D9)),
                pastelButton("Lap", addLap, const Color(0xFFFFF1C1)),
                pastelButton("Reset", resetTimer, const Color(0xFFEDEDE9)),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                itemCount: laps.length,
                itemBuilder: (_, i) => Text(
                  laps[i],
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    shadows: [Shadow(blurRadius: 4, color: Colors.black45, offset: Offset(1, 1))],
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
