import 'package:flutter/material.dart';

class AppCercelTitel extends StatelessWidget {
  final String imagePath;
  final String description;
  final VoidCallback onPressed;
  const AppCercelTitel({
    super.key,
    required this.imagePath,
    required this.description,
    this.onPressed = _emptyCallback,
  });
  static void _emptyCallback() {}
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // box cercel with border blue contain image fill the box with asset logo.png
        InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(40),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(
                    255,
                    90,
                    87,
                    87,
                  ).withValues(alpha: 0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue, width: 2),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(imagePath),
              ),
            ),
          ),
        ),
        Text(description, style: TextStyle(color: Colors.blue)),
      ],
    );
  }
}
