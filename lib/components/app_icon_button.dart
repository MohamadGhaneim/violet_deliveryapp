import 'package:deliveryapp/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final VoidCallback onPress;
  final IconData icon;
  final Color? btnColor;
  final Color? colorContent;
  final String? text;
  const AppIconButton({
    super.key,
    required this.onPress,
    required this.icon,
    this.btnColor = Colors.white,
    this.text,
    this.colorContent = AppColors.deepBlue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(10),
          backgroundColor: btnColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: colorContent, size: 30),
            Text(text as String, style: TextStyle(color: colorContent)),
          ],
        ),
      ),
    );
  }
}
