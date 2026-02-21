import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  final String imagePath;
  const AppImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.asset(imagePath, fit: BoxFit.fill, width: double.infinity),
      ),
    );
  }
}
