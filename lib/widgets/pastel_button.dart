import 'package:flutter/material.dart';

Widget pastelButton(String text, VoidCallback onTap, Color bg) {
  return ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
      backgroundColor: bg,
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    child: Text(text),
  );
}
