import 'package:flutter/material.dart';

class AppAddToCard extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? bgColor;
  final Color? textColor;
  final bool? isload;
  const AppAddToCard({
    super.key,
    required this.onPressed,
    required this.text,
    this.bgColor = Colors.blue,
    this.textColor = Colors.white,
    this.isload = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child:
          isload == true
              ? Center(child: CircularProgressIndicator(color: textColor))
              : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  backgroundColor: bgColor,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: onPressed,
                child: Text(text, style: TextStyle(color: textColor)),
              ),
    );
  }
}
