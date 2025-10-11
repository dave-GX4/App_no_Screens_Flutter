import 'package:flutter/material.dart';

class CustomTextlink extends StatelessWidget {
  final String text;
  final VoidCallback onTap; // Acepta cualquier función como acción

  const CustomTextlink({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
            decorationColor: Colors.blue,
            fontSize: 16.0,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}