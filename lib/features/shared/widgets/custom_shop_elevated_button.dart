import 'package:flutter/material.dart';

class CustomShopElevatedButton extends StatefulWidget {
  final ButtonSize? buttonSize;
  final String label;
  final void Function()? onPressed;
  final Color color;
  const CustomShopElevatedButton(
      {super.key, this.buttonSize, this.label = 'Button', this.onPressed, required this.color});

  @override
  CustomShopElevatedButtonState createState() => CustomShopElevatedButtonState();
}

class CustomShopElevatedButtonState extends State<CustomShopElevatedButton> {
  // Color _buttonColor = Colors.yellow;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.buttonSize?.getSize(MediaQuery.of(context).size),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color, // Color de fondo del botón
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // Esquinas redondeadas
          ),
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        ),
        onPressed: widget.onPressed, // Llamar a la función _changeColor cuando se presione el botón
        child: Text(
          widget.label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

enum ButtonSize {
  small,
  medium,
  large;

  double getSize(Size size) {
    switch (this) {
      case ButtonSize.small:
        return size.width * .6;
      case ButtonSize.medium:
        return size.width * .75;

      case ButtonSize.large:
        return size.width * .9;
    }
  }
}
