import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height * 2.3;
    final width = size.width;
    const colors = [
      Color(0xffFFEAB5),
      Color(0xffFFC63B),
    ];

    final stops = [0.0, .5];
    final center = Offset(width * .7, height * .05);

    final gradient = RadialGradient(colors: colors, center: Alignment.center, radius: .4, stops: stops);
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = gradient.createShader(Rect.fromCircle(center: center, radius: 600));

    final path = Path()
      ..moveTo(width, height * .4) //0
      ..quadraticBezierTo(width * 0.9, height * 0.41, width * 0.5, height * 0.37) // 1
      ..quadraticBezierTo(width * 0.250, height * 0.345, width * 0.15, height * 0.36) // 2
      ..quadraticBezierTo(width * 0.3, height * 0.323, width * 0.6, height * 0.34) // 3
      ..quadraticBezierTo(width * 0.8750, height * 0.358, width, height * 0.35) // 4
      //------------------------------
      ..moveTo(width, height * .325) //0
      ..quadraticBezierTo(width * 0.9, height * 0.34, width * 0.5, height * 0.315) // 1
      ..quadraticBezierTo(width * 0.1, height * 0.31, width * 0, height * 0.4) // 2
      ..lineTo(0, height * 0)
      ..lineTo(width, height * 0);

    final paintWhiteLine = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;

    final pathWhiteLine = Path()
          ..moveTo(width, height * .35)
          ..lineTo(width, height * .325)
          ..quadraticBezierTo(width * 0.9, height * 0.34, width * 0.5, height * 0.315) // 1
          ..quadraticBezierTo(width * 0.1, height * 0.31, width * 0, height * 0.4) // 2
          ..quadraticBezierTo(width * 0.1, height * 0.362, width * 0.15, height * 0.36) // 3
          ..quadraticBezierTo(width * 0.3, height * 0.323, width * 0.6, height * 0.34) // 4
          ..quadraticBezierTo(width * 0.9, height * 0.3595, width, height * 0.35) // 4

        ;

    canvas.drawPath(path, paint);
    canvas.drawPath(pathWhiteLine, paintWhiteLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
