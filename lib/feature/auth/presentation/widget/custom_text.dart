import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? colors;
  final double size;
  final FontWeight? fontweight;

  const CustomText({
    super.key,
    required this.text,
    this.fontweight = FontWeight.normal,
    this.size = 16.0,
    this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: colors,
        fontSize: size,
        fontWeight: fontweight,
      ),
      textAlign: TextAlign.center,
    );
  }
}