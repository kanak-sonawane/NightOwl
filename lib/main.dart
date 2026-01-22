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

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  int selectedIndex = 0;

  String assetBg = 'assets/backgrounds/img.jpg'; // Initialize with default
  String? fileBgPath;
  bool isLoading = true; // Add loading flag

  @override
  void initState() {
    super.initState();
    loadBackground();
  }

  Future<void> loadBackground() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      assetBg = prefs.getString('asset_bg') ?? 'assets/backgrounds/img.jpg';
      fileBgPath = prefs.getString('file_bg');
      isLoading = false; // Done loading
    });
  }

  Future<void> setAssetBg(String bg) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('asset_bg', bg);
    await prefs.remove('file_bg'); // IMPORTANT

    setState(() {
      assetBg = bg;
      fileBgPath = null;
    });
  }

  Future<void> setFileBg(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('file_bg', path);

    setState(() {
      fileBgPath = path;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show loading while preferences are being loaded
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final screens = [
      TimerScreen(
        assetBg: assetBg,
        fileBgPath: fileBgPath,
      ),
      BackgroundScreen(
        currentAssetBg: assetBg,
        onAssetSelect: setAssetBg,
        onFileSelect: setFileBg,
      ),
    ];

    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (i) => setState(() => selectedIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Timer'),
          BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Backgrounds'),
        ],
      ),
    );
  }
}