import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/features/shared/widgets/custom_shop_elevated_button.dart';

class CustomBannerContainer extends ConsumerWidget {
  final String imageBannerPath;
  final String title;
  final String subtitle;
  final String? buttonLabel;
  final void Function()? onTap;
  const CustomBannerContainer(
      {super.key,
      this.buttonLabel,
      required this.imageBannerPath,
      this.title = 'Title',
      this.subtitle = "",
      this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(30),
      ),
      width: screenSize.width * .9,
      height: screenSize.height * .3,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Center(
              child: SizedBox(
                height: screenSize.height * .3,
                child: Image.asset(
                  imageBannerPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: 40,
            top: 40,
            child: Container(
              constraints: BoxConstraints(maxWidth: screenSize.width * .5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textStyle.headlineLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (subtitle != '')
                    Text(
                      subtitle,
                      style: textStyle.headlineMedium!.copyWith(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  if (onTap != null)
                    CustomShopElevatedButton(
                      color: Colors.amber,
                      onPressed: onTap,
                      buttonSize: ButtonSize.medium,
                      label: buttonLabel ?? '',
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
