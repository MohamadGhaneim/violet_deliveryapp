// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:deliveryapp/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AppElevatedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? bgColor;
  final Color? textColor;
  final double? radius;
  final bool isWait;
  const AppElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.bgColor = Colors.red,
    this.textColor = Colors.white,
    this.radius = 16,
    required this.isWait,
  });

  @override
  State<AppElevatedButton> createState() => _AppElevatedButtonState();
}

class _AppElevatedButtonState extends State<AppElevatedButton> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.bgColor,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.radius ?? 16),
          ),
        ),
        onPressed: widget.isWait ? null : widget.onPressed,

        child:
            widget.isWait
                ? CircularProgressIndicator(
                  strokeWidth: screenWidth * 0.0045,
                  color: AppColors.deepBlue,
                )
                : Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    color: widget.textColor,
                  ),
                ),
      ),
    );
  }
}
