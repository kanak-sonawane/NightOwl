import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BackgroundScreen extends StatelessWidget {
  final String currentAssetBg;
  final Function(String) onAssetSelect;
  final Function(String) onFileSelect;

  const BackgroundScreen({
    super.key,
    required this.currentAssetBg,
    required this.onAssetSelect,
    required this.onFileSelect,
  });

  final List<String> backgrounds = const [
    'assets/backgrounds/img.jpg',
    'assets/backgrounds/img1.jpg',
    'assets/backgrounds/img3.jpg',
    'assets/backgrounds/img4.jpg',
  ];

  Future<void> pickCustomImage(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );

    if (image != null) {
      onFileSelect(image.path);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Background updated ✨")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Choose Background'),
        backgroundColor: const Color(0xFFF8F9FA),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          /// ---------- CUSTOM IMAGE PICKER (NON-SCROLLABLE) ----------
          Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () => pickCustomImage(context),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade200,
                  border: Border.all(color: Colors.black12),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_photo_alternate, size: 40),
                      SizedBox(height: 8),
                      Text(
                        "Set your own background",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// ---------- APP BACKGROUNDS (SCROLLABLE) ----------
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.75,
              ),
              itemCount: backgrounds.length,
              itemBuilder: (_, index) {
                final bg = backgrounds[index];
                final selected = bg == currentAssetBg;

                return GestureDetector(
                  onTap: () => onAssetSelect(bg),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: selected
                          ? Border.all(color: Colors.black, width: 3)
                          : Border.all(color: Colors.black12),
                      image: DecorationImage(
                        image: AssetImage(bg),
                        fit: BoxFit.cover,
                        onError: (error, stackTrace) {
                          print('🔴 Error loading background: $bg');
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}