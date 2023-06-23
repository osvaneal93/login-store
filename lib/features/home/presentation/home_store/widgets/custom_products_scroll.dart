import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/core/paths.dart';
import 'package:multi_store_app/features/auth/data/models/product_model.dart';

class CustomProductsScroll extends ConsumerWidget {
  final List<ProductModel> productList;
  final Widget widgetLabel;
  const CustomProductsScroll({super.key, required this.productList, required this.widgetLabel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: const Offset(2, 5), blurRadius: 10, spreadRadius: 1, color: Colors.grey.withOpacity(.2)),
              ],
            ),
            height: screenSize.height * .35,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: widgetLabel,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          child: SizedBox(
            height: screenSize.height * .28,
            width: screenSize.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    productList.length,
                    (index) => ProductCard(
                        screenSize: screenSize, productList: productList, textStyle: textStyle, index: index)),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard(
      {super.key, required this.screenSize, required this.productList, required this.textStyle, required this.index});

  final Size screenSize;
  final List<ProductModel> productList;
  final TextTheme textStyle;

  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(index);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: screenSize.height * .28,
        width: screenSize.width * .33,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 252, 249, 239),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: screenSize.height * .17,
              margin: const EdgeInsets.symmetric(
                vertical: 3,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10,
                ),
                boxShadow: [
                  BoxShadow(blurRadius: 5, spreadRadius: 1, offset: Offset(4, 4), color: Colors.grey.withOpacity(.2)),
                ],
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      paths.womanModel,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (productList[index].discount != null)
                    Positioned(
                        right: 5,
                        top: 5,
                        child: Container(
                          decoration:
                              BoxDecoration(color: Colors.red.shade400, borderRadius: BorderRadius.circular(10)),
                          child: Text('${productList[index].discount}% off', style: textStyle.labelSmall),
                        ))
                ],
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                productList[index].brand ?? '',
                style: textStyle.labelSmall!.copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Container(
              constraints: const BoxConstraints(
                maxHeight: 30,
              ),
              child: Text(
                productList[index].name ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textStyle.labelSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  (productList[index].discount != null)
                      ? Text(
                          '\$ ${getPriceDiscount(productList[index].price, productList[index].discount)}',
                          style: textStyle.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.amber),
                        )
                      : Text(
                          '\$ ${productList[index].price}',
                          style: textStyle.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.amber),
                        ),
                  SizedBox(
                    width: 10,
                  ),
                  if (productList[index].discount != null)
                    Text(
                      '\$ ${productList[index].price}',
                      style: textStyle.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.grey),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double getPriceDiscount(int? price, int? discount) {
    final finalPrice = price! - (price * (discount! / 100));
    double truncatedNumber = double.parse(finalPrice.toStringAsFixed(2));

    return truncatedNumber;
  }
}
