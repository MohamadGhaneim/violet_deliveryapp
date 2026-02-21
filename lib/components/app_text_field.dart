import 'package:deliveryapp/styles/app_colors.dart';
import 'package:flutter/material.dart';
//import 'package:transportation/styles/app_colors.dart';

class AppTextField extends StatelessWidget {
  final String hint;
  final Icon icon;
  final bool obscureText;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final TextInputType? inputType;
  const AppTextField({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
    this.obscureText = false,
    this.onChanged,
    this.inputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      keyboardType: inputType,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: icon,
        hintText: hint,
        //labelText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: AppColors.lightGray,
      ),
    );
  }
}
