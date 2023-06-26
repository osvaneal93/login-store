import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/core/paths.dart';
import 'package:multi_store_app/features/home/presentation/home_store/widgets/deliver_item/delivery_custom_painter_item.dart';

class CustomDeliverItem extends ConsumerWidget {
  final bool isSelected;
  final String imagePath;
  final String title;
  final String address;
  final String phoneNumber;
  final void Function()? onTap;

  const CustomDeliverItem(
      {required this.title,
      required this.address,
      required this.phoneNumber,
      super.key,
      required this.imagePath,
      required this.isSelected,
      this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: screenSize.height * .22,
        width: screenSize.width * .9,
        margin: const EdgeInsets.all(20),
        child: CustomPaint(
          painter: CurvedRectanglePainter(borderColor: isSelected ? Colors.amber : Colors.grey),
          child: Container(
            padding: const EdgeInsets.all(1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          height: 50,
                          width: 50,
                          child: Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.background,
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(2, 2),
                                        blurRadius: 2,
                                        spreadRadius: 0,
                                        color: Colors.grey.withOpacity(.7))
                                  ],
                                  border: Border.all(color: isSelected ? Colors.amber : Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                height: 50,
                                width: 50,
                                child: Image.asset(imagePath),
                              ),
                              if (isSelected)
                                Positioned(
                                  right: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: isSelected ? Colors.amber : Colors.grey, width: 2),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    height: 15,
                                    width: 15,
                                    child: const Center(
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.amber,
                                        size: 10,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          title,
                          style: textStyle.bodyLarge!
                              .copyWith(color: isSelected ? Colors.amber : Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      constraints: BoxConstraints(maxWidth: screenSize.width * .6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            address,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            phoneNumber,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    paths.mapHardcode,
                    height: 70,
                    width: 70,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
