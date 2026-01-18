import 'package:flutter/material.dart';

class BackgroundScreen extends StatelessWidget {
  final String currentBg;
  final Function(String) onSelect;

  const BackgroundScreen({super.key, required this.currentBg, required this.onSelect});

  final List<String> backgrounds = const [
    'assets/backgrounds/img.jpg',
    'assets/backgrounds/img1.jpg',
    'assets/backgrounds/img3.jpg',
    'assets/backgrounds/img4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Background'),
        backgroundColor: const Color(0xFFF8F9FA),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
        ),
        itemCount: backgrounds.length,
        itemBuilder: (_, index) {
          final bg = backgrounds[index];
          final selected = bg == currentBg;
          return GestureDetector(
            onTap: () => onSelect(bg),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: selected ? Border.all(color: Colors.black, width: 3) : null,
                image: DecorationImage(image: AssetImage(bg), fit: BoxFit.cover),
              ),
            ),
          );
        },
      ),
    );
  }
}
