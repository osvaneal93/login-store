import 'package:flutter/material.dart';
import 'package:multi_store_app/core/paths.dart';

class HeaderSlivers extends SliverPersistentHeaderDelegate {
  final IconData? icon;
  final IconData? subIcon;
  final IconData? terciaryicon;
  final String? avatarPath;
  final String label;
  final String subtitle;
  final String terciaryText;
  final void Function()? onTap, onPressedIcon, onPressedSubIcon;

  HeaderSlivers(
      {this.onPressedIcon,
      this.onPressedSubIcon,
      this.icon,
      this.label = 'Label',
      this.subtitle = 'Subtitule',
      this.terciaryText = 'Tertiary',
      this.subIcon,
      this.terciaryicon,
      this.avatarPath,
      this.onTap});
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final textStyle = Theme.of(context).textTheme;
    final percent = shrinkOffset / 100;
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          color: percent > .2 ? Colors.grey.shade100 : Colors.white,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: onTap,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        CustomCircleAvatar(avatarPath: avatarPath, percent: percent),
                        const SizedBox(
                          width: 20,
                        ),
                        CustomHeaderLabels(label: label, textStyle: textStyle, subtitle: subtitle, percent: percent),
                        SizedBox(
                          width: 50,
                        )
                      ],
                    ),
                  ),
                  CustomAnimatedOpacityIcon(percent: percent, icon: icon, onPressed: onPressedIcon),
                  CustomAnimatedOpacityIcon(percent: percent, icon: subIcon, onPressed: onPressedSubIcon),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),

              // CustomHeaderTitle(percent: percent, icon: icon, label: label, textStyle: textStyle),
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

class CustomAnimatedOpacityIcon extends StatelessWidget {
  const CustomAnimatedOpacityIcon({super.key, required this.percent, required this.icon, this.onPressed});

  final double percent;
  final IconData? icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        opacity: percent > .1 ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: IconButton(onPressed: onPressed, icon: Icon(icon), iconSize: 35, color: Colors.grey.shade500));
  }
}

class CustomHeaderLabels extends StatelessWidget {
  const CustomHeaderLabels(
      {super.key, required this.label, required this.textStyle, required this.subtitle, required this.percent});

  final String label;
  final TextTheme textStyle;
  final String subtitle;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: const Duration(milliseconds: 200),
      offset: Offset(percent < .1 ? 1 : 0, 0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: textStyle.bodySmall
                    ?.copyWith(fontWeight: FontWeight.w600, color: textStyle.bodyLarge!.color!.withOpacity(.5)),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                subtitle,
                style: textStyle.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey, width: 3),
            ),
            child: const Center(
                child: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 20,
              color: Colors.grey,
            )),
          )
        ],
      ),
    );
  }
}

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    super.key,
    required this.percent,
    required this.avatarPath,
  });

  final String? avatarPath;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: const Duration(milliseconds: 200),
      offset: Offset(percent < .1 ? 1.5 : 0, 0),
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
          BoxShadow(offset: const Offset(2, 3), blurRadius: 5, spreadRadius: 1, color: Colors.grey.withOpacity(.8))
        ]),
        child: CircleAvatar(
          backgroundImage: avatarPath == null ? null : NetworkImage(avatarPath ?? ''),
          radius: 30,
          child: avatarPath == null
              ? Container(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(paths.userAvatar),
                )
              : null,
        ),
      ),
    );
  }
}
