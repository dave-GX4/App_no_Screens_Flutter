import 'package:flutter/material.dart';

class CustomIconbutton extends StatelessWidget{
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;
  final double size;
  
  const CustomIconbutton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color = Colors.black,
    this.size = 24.0,
  });

  @override
  Widget build( BuildContext context){
    return IconButton(
      icon: Icon(
        icon, 
        color: color, 
        size: size
      ),
      onPressed: onPressed,
    );
  }
}