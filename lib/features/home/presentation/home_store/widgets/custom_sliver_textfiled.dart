import 'package:flutter/material.dart';
import 'package:multi_store_app/features/shared/widgets/custom_shop_textfield.dart';

typedef OnHeaderChange = void Function(bool visible);

class CustomSliverTextfield extends SliverPersistentHeaderDelegate {
  final String label;
  final String? hintText;
  final IconData? suffixIcon;
  final OnHeaderChange onHeaderChange;

  CustomSliverTextfield({this.label = 'Label', required this.onHeaderChange, this.suffixIcon, this.hintText});
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Center(
      child: CustomShopTextfield(
        textInputAction: TextInputAction.search,
        height: 60,
        width: 350,
        icon: suffixIcon,
        hintText: hintText,
      ),
    );
  }

  @override
  double get maxExtent => 80.0;

  @override
  double get minExtent => 80.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
