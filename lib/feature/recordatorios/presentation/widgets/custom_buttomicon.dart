import 'package:flutter/material.dart';

class CustomButtomIcon extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final IconData icon;
  final Color? inColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final BorderRadius? borderRadius;
  final Border? border;

  const CustomButtomIcon({
    super.key,
    required this.text,
    required this.onPressed,
    required this.width, 
    required this.height, 
    required this.icon,
    this.inColor = Colors.white,
    this.color = Colors.black,
    this.textColor = Colors.white, 
    this.fontSize = 16, 
    this.fontWeight = FontWeight.normal, 
    this.borderRadius = const BorderRadius.all(Radius.circular(8)), 
    this.border = const Border.fromBorderSide(BorderSide.none),
  });

  @override
  Widget build(BuildContext context){
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(width!, height!),
        shape: RoundedRectangleBorder(borderRadius: borderRadius!),
        side: border!.top,
      ), 
      label: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
      icon: Icon(
        icon,
        color: inColor
      ),
    );
  }
}