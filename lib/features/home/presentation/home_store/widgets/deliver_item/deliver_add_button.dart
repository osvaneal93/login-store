import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/features/home/presentation/home_store/widgets/deliver_item/delivery_custom_painter_item.dart';

class DeliverAddButton extends ConsumerWidget {
  const DeliverAddButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height * .08,
      width: screenSize.width * .9,
      child: CustomPaint(
        painter: CurvedRectanglePainter(borderColor: Colors.grey),
      ),
    );
  }
}
