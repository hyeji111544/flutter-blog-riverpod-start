import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback click;

  CustomTextButton({required this.text, required this.click});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: click,
      child: Text(text,
          style: const TextStyle(
              color: Colors.black87, decoration: TextDecoration.underline)),
    );
  }
}
