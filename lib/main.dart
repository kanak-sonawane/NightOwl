import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/timer_screen.dart';
import 'screens/background_screen.dart';

void main() {
  runApp(const NightOwlApp());
}

class NightOwlApp extends StatelessWidget {
  const NightOwlApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeWrapper(),
    );
  }
}

/* ---------------- HOME WRAPPER ---------------- */

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  int selectedIndex = 0;
  String selectedBackground = 'assets/backgrounds/img.jpg';

  @override
  void initState() {
    super.initState();
    loadSavedBackground();
  }

  // LOAD saved background
  Future<void> loadSavedBackground() async {
    final prefs = await SharedPreferences.getInstance();
    final savedBg = prefs.getString('selected_bg');

    if (savedBg != null) {
      setState(() {
        selectedBackground = savedBg;
      });
    }
  }

  // SAVE background
  Future<void> updateBackground(String bg) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_bg', bg);

    setState(() {
      selectedBackground = bg;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      TimerScreen(background: selectedBackground),
      BackgroundScreen(
        currentBg: selectedBackground,
        onSelect: updateBackground,
      ),
    ];

    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => setState(() => selectedIndex = index),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFFF8F9FA),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Timer'),
          BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Backgrounds'),
        ],
      ),
    );
  }
}
