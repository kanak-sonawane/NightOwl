import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import '../widgets/pastel_button.dart';

class TimerScreen extends StatefulWidget {
  final String assetBg;
  final String? fileBgPath;

  const TimerScreen({
    super.key,
    required this.assetBg,
    this.fileBgPath,
  });

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int seconds = 0;
  Timer? timer;
  List<String> laps = [];

  void startTimer() {
    timer ??= Timer.periodic(
      const Duration(seconds: 1),
      (_) => setState(() => seconds++),
    );
  }

  void stopTimer() {
    timer?.cancel();
    timer = null;
  }

  void resetTimer() {
    stopTimer();
    setState(() {
      seconds = 0;
      laps.clear();
    });
  }

  void addLap() {
    if (seconds > 0) {
      setState(() {
        laps.insert(0, timerText);
      });
    }
  }

  String get timerText {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = seconds % 60;
    return "${h.toString().padLeft(2, '0')}:"
        "${m.toString().padLeft(2, '0')}:"
        "${s.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Positioned.fill(
            child: widget.fileBgPath != null
                ? Image.file(
                    File(widget.fileBgPath!),
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    widget.assetBg,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade300,
                        child: const Center(
                          child: Icon(Icons.image_not_supported, size: 64),
                        ),
                      );
                    },
                  ),
          ),
          
          // Timer UI
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 80),
                // Timer Display
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
                
                // Buttons
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    pastelButton("Start", startTimer, const Color(0xFFD8F3DC)),
                    pastelButton("Stop", stopTimer, const Color(0xFFFFE5D9)),
                    pastelButton("Lap", addLap, const Color(0xFFFFF1C1)),
                    pastelButton("Reset", resetTimer, const Color(0xFFEDEDE9)),
                  ],
                ),
                
                const SizedBox(height: 40),
                
                // Laps List - Clean minimal style
                if (laps.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      itemCount: laps.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Lap ${laps.length - index}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 6,
                                      color: Colors.black54,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                laps[index],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 6,
                                      color: Colors.black54,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}