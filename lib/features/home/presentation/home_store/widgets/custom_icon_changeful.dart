import 'package:flutter/material.dart';

class ColorChangingIcon extends StatefulWidget {
  const ColorChangingIcon({super.key});

  @override
  ColorChangingIconState createState() => ColorChangingIconState();
}

class ColorChangingIconState extends State<ColorChangingIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  final Color _startColor = Colors.grey; // Color inicial del icono
  final Color _endColor = Colors.yellow; // Color final del icono

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800), // Duración de la animación
      vsync: this,
    );

    _colorAnimation = ColorTween(
      begin: _startColor,
      end: _endColor,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return InkWell(
          onTap: () {
            _controller.forward();
          },
          child: Icon(
            Icons.star,
            color: _colorAnimation.value,
            size: 24.0,
          ),
        );
      },
    );
  }
}
