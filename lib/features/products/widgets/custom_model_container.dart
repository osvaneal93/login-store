import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/features/shared/widgets/custom_shop_elevated_button.dart';

class CustomModelContainer extends ConsumerWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final String labelButton;
  const CustomModelContainer({
    required this.labelButton,
    super.key,
    this.title = 'title',
    this.subtitle = 'Subtitle',
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(offset: const Offset(2, 5), blurRadius: 10, spreadRadius: 1, color: Colors.grey.withOpacity(.2)),
          ],
        ),
        height: screenSize.height * .35,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  constraints:
                      BoxConstraints(maxWidth: screenSize.width * .45, maxHeight: (screenSize.height * .35) / 1.8),
                  child: Text(
                    title,
                    style: textStyle.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.amber),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  constraints:
                      BoxConstraints(maxWidth: screenSize.width * .45, maxHeight: (screenSize.height * .35) / 1.8),
                  child: Text(
                    subtitle,
                    style: textStyle.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomShopElevatedButton(
                  color: Colors.amber,
                  onPressed: () {},
                  label: labelButton,
                )
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                  width: screenSize.width * .45,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
