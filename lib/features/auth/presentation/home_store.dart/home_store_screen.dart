import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/core/paths.dart';
import 'package:multi_store_app/features/auth/presentation/home_store.dart/widgets/flexible_header.dart';
import 'package:multi_store_app/features/auth/presentation/home_store.dart/widgets/headers_slivers.dart';
// import 'package:multi_store_app/features/shared/widgets/custom_shop_elevated_button.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});
  static const String path = '/';

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              FlexibleSpaceBarHeader(
                backgroundImage: Image.asset(
                  paths.modelsHeader,
                  fit: BoxFit.cover,
                ),
                leftIcon: Icons.menu,
                rightIcon: Icons.info,
              ),
              SliverPersistentHeader(
                delegate: HeaderSlivers(
                    icon: Icons.check,
                    label: 'Bienvenido de nuevo',
                    subIcon: Icons.exposure_zero,
                    subtitle: 'Notificaciones',
                    terciaryicon: Icons.star,
                    terciaryText: '123 Likes'),
                pinned: true,
              ),
              ...List.generate(
                10,
                (index) => SliverPersistentHeader(delegate: ContainerSlivers()),
              )
            ],
          ),
        ],
      ),
    );
  }
}
