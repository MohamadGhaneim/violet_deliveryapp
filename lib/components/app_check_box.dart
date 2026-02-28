import 'package:deliveryapp/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AppCheckBox extends StatelessWidget {
  final bool isChecked;
  final String label;
  final ValueChanged<bool?> onChanged;
  final bool isloading;

  const AppCheckBox({
    super.key,
    required this.isChecked,
    required this.label,
    required this.onChanged,
    required this.isloading,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CheckboxListTile(
          value: isChecked,
          onChanged: isloading ? null : onChanged,
          title: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          activeColor: AppColors.deepBlue,
          checkColor: Colors.white,
          tileColor: AppColors.deepBlue.withValues(alpha: 0.05),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          controlAffinity: ListTileControlAffinity.leading,
        ),

        if (isloading)
          const Positioned.fill(
            child: Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),
      ],
    );
  }
}
