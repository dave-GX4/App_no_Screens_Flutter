import 'package:flutter/material.dart';

class CustomLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromRGBO(177, 131, 243, 1)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    final Offset startPoint = Offset(0, 0);
    final Offset endPoint = Offset(size.width, size.height);

    canvas.drawLine(startPoint, endPoint, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}