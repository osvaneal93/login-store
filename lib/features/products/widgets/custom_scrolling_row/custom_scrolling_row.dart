import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/features/products/widgets/custom_scrolling_row/custom_scroll_provider.dart';

class CustomScrollingRow extends SliverPersistentHeaderDelegate {
  CustomScrollingRow();
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return const CustomScrollingHelper();
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

class CustomScrollingHelper extends ConsumerStatefulWidget {
  const CustomScrollingHelper({
    super.key,
  });

  @override
  CustomScrollingHelperState createState() => CustomScrollingHelperState();
}

class CustomScrollingHelperState extends ConsumerState {
  final _scrollController = ScrollController();
  final List<String> productsList = [
    'All categories',
    'Man',
    'Womamn',
    "Kids",
    'accesories',
    "shoes",
    "music",
    "books",
    "others"
  ];
  late List<double> itemWithList;
  late List<double> newList;

  final List<GlobalKey> itemKeys = List.generate(9, (index) => GlobalKey());

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customScrollerRead = ref.read(customScrollProvider.notifier);
    final customScrollerWatch = ref.watch(customScrollProvider);
    final textStyle = Theme.of(context).textTheme;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      newList = [];
      itemWithList = List.generate(productsList.length, (index) {
        final itemsBox = itemKeys[index].currentContext!.findRenderObject() as RenderBox;
        return itemsBox.size.width;
      });
      double sum = 0.0;
      for (int i = 0; i < itemWithList.length; i++) {
        sum += itemWithList[i];
        newList.add(sum);
      }
    });

    void scrollToSelectedIndex(int index) {
      customScrollerRead.changeItemIndex(index);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        RenderBox renderBox = itemKeys[index].currentContext!.findRenderObject() as RenderBox;
        double widgetWidth = renderBox.size.width;
        if (_scrollController.hasClients) {
          final itemPosition = newList[index] - widgetWidth;

          _scrollController.animateTo(
            itemPosition,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    }

    // return CustomScrollingRow(customScrollerProvider.index);
    return SizedBox(
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            productsList.length,
            (index) {
              return InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () => scrollToSelectedIndex(index),
                child: AnimatedContainer(
                  key: itemKeys[index],
                  duration: const Duration(milliseconds: 100),
                  height: 40,
                  margin: const EdgeInsets.all(7),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: customScrollerWatch.index == index ? Colors.amber : Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: customScrollerWatch.index == index ? Colors.transparent : Colors.grey, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      productsList[index],
                      overflow: TextOverflow.ellipsis,
                      style: textStyle.labelLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: customScrollerWatch.index == index ? Colors.white : textStyle.bodyLarge?.color,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
