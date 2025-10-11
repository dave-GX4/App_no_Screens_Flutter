import 'package:flutter/material.dart';

class CustomElevatebutton extends StatelessWidget{
  final VoidCallback? onPressed;
  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final Color? backgroundColor;
  final IconData? icon;

  const CustomElevatebutton({
    super.key, 
    this.onPressed, 
    this.backgroundColor = const Color.fromARGB(255, 76, 91, 175),
    this.icon = Icons.send,
    required this.text,  
    required this.fontWeight, 
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        )
      ),
      icon: Icon(
        icon, 
        color: Colors.white
      ),
      label: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: Colors.white
        ),
      ),
    );
  }
}