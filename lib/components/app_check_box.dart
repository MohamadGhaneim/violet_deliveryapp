import 'package:deliveryapp/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AppCheckBox extends StatelessWidget {
  final bool isChecked;
  final String label;
  final ValueChanged<bool?> onChanged;

  const AppCheckBox({
    super.key,
    required this.isChecked,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: isChecked,
      onChanged: onChanged,
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      activeColor: AppColors.deepBlue,
      checkColor: Colors.white,
      tileColor: AppColors.deepBlue.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
