import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlexibleSpaceBarHeader extends ConsumerWidget {
  final Widget backgroundImage;
  final IconData? leftIcon, rightIcon;
  final void Function()? onTapLeftIcon, onTapRightIcon;
  const FlexibleSpaceBarHeader({
    super.key,
    this.onTapLeftIcon,
    this.onTapRightIcon,
    this.leftIcon,
    this.rightIcon,
    required this.backgroundImage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    return SliverAppBar(
      expandedHeight: screenSize.height * .4,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        stretchModes: const [
          StretchMode.zoomBackground,
        ],
        background: Stack(
          children: [
            SizedBox(
              height: screenSize.height * .4,
              width: screenSize.width,
              child: backgroundImage,
            ),
            Positioned(
              left: 25,
              top: 25,
              child: InkWell(
                onTap: onTapLeftIcon,
                child: Icon(
                  leftIcon,
                  size: 30,
                ),
              ),
            ),
            Positioned(
              right: 25,
              top: 25,
              child: InkWell(
                onTap: onTapRightIcon,
                child: Icon(
                  rightIcon,
                  size: 30,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
