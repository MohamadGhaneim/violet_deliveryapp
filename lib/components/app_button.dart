import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final String hint;
  final TextEditingController controller;

  const AppButton({
    super.key,
    required this.imagePath,
    required this.label,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Image.asset(imagePath, width: 30.0, height: 30.0),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 48,
          minHeight: 48,
        ),
        labelText: label,
        hintText: 'phone number',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      style: const TextStyle(
        fontSize: 16.0,
        fontFamily: 'jetBrainsMono',
        color: Colors.black,
      ),
      textAlignVertical: TextAlignVertical.center,
    );
  }
}
