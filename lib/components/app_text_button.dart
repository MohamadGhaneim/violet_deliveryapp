import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final double fontSize;
  final String text;
  const AppTextButton({
    super.key,
    required this.text,
    required this.color,
    required this.fontSize,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          decoration: TextDecoration.underline,
          decorationColor: Colors.blue,
          color: Colors.blue,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
