import 'package:flutter/material.dart';

typedef OnHeaderChange = void Function(bool visible);

class ContainerSlivers extends SliverPersistentHeaderDelegate {
  final String label;
  final OnHeaderChange onHeaderChange;

  ContainerSlivers({this.label = 'Label', required this.onHeaderChange});
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // if (shrinkOffset > 0) {
    //   print(shrinkOffset);
    //   onHeaderChange(true);
    // } else {
    //   print('SIN OFFSSSS');

    //   onHeaderChange(false);
    // }
    return Stack(
      children: [
        Container(
          color: Colors.amber,
          height: 190.0,
          margin: const EdgeInsets.all(10),
          child: Center(
            child: Text(
              label,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 190.0;

  @override
  double get minExtent => 190.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
