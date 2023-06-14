import 'package:flutter/material.dart';

class HeaderSlivers extends SliverPersistentHeaderDelegate {
  final IconData? icon;
  final IconData? subIcon;
  final IconData? terciaryicon;

  final String label;
  final String subtitle;
  final String terciaryText;

  HeaderSlivers(
      {this.icon,
      this.label = 'Label',
      this.subtitle = 'Subtitule',
      this.terciaryText = 'Tertiary',
      this.subIcon,
      this.terciaryicon});
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final textStyle = Theme.of(context).textTheme;
    return Stack(
      children: [
        Container(
          color: Theme.of(context).colorScheme.secondaryContainer,
          height: 100.0,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    icon,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    label,
                    style: textStyle.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    subIcon,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    subtitle,
                    style: textStyle.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    terciaryicon,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    terciaryText,
                    style: textStyle.bodySmall?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 100.0;

  @override
  double get minExtent => 100.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

class ContainerSlivers extends SliverPersistentHeaderDelegate {
  final String label;

  ContainerSlivers({
    this.label = 'Label',
  });
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        Container(
          color: Colors.amber,
          height: 120.0,
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
  double get maxExtent => 100.0;

  @override
  double get minExtent => 100.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
