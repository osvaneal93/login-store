import 'package:flutter/material.dart';

class CustomSocialButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;

  const CustomSocialButton({super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: OutlinedButton(
        onPressed: onPressed as void Function()?,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
          foregroundColor: Colors.black54,
          shadowColor: Colors.transparent,
          elevation: 0.0,
          side: const BorderSide(color: Colors.grey), // Borde de color negro
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // Esquinas redondeadas
          ),
        ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
        child: child,
      ),
    );
  }
}
