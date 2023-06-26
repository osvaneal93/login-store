import 'package:flutter/material.dart';

class CurvedRectanglePainter extends CustomPainter {
  final Color borderColor;
  final Color backgroundColor;

  CurvedRectanglePainter({required this.borderColor, this.backgroundColor = Colors.transparent});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.5;
    final border = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path()
      ..moveTo(20, 0)
      ..quadraticBezierTo(2, 2, 0, 20)
      ..quadraticBezierTo(-1.5, size.height * .5, 0, size.height - 20)
      ..quadraticBezierTo(-2, size.height, 20, size.height)
      ..quadraticBezierTo(size.width * .5, size.height + 3, size.width - 20, size.height)
      ..quadraticBezierTo(size.width + 2, size.height, size.width, size.height - 20)
      ..quadraticBezierTo(size.width + 1.5, size.height * .5, size.width, 20)
      ..quadraticBezierTo(size.width, 0, size.width - 20, 0)
      ..quadraticBezierTo(size.width * .5, -3, 20, 0);

    canvas.drawPath(path, paint);
    canvas.drawPath(path, border);
  }

  @override
  bool shouldRepaint(CurvedRectanglePainter oldDelegate) => false;
}
