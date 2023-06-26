import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/features/home/presentation/account_store/account_store_screen.dart';
import 'package:multi_store_app/features/home/presentation/discover_store/discover_store_screen.dart';
import 'package:multi_store_app/features/home/presentation/favorites_store/favorites_store_screen.dart';
import 'package:multi_store_app/features/home/presentation/home_store/home_store_screen.dart';
import 'package:multi_store_app/features/providers/bottomNavBar/bottom_nav_bar_provider.dart';

class PageViewHome extends ConsumerStatefulWidget {
  static const String path = '/';

  const PageViewHome({super.key});

  @override
  PageViewHomeState createState() => PageViewHomeState();
}

class PageViewHomeState extends ConsumerState {
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(bottomNavBarProvider, (previous, next) {
      if (previous?.currentPage != next.currentPage) {
        pageController.animateToPage(next.currentPage,
            duration: const Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
      }
    });
    final List<Widget> pageviewItems = [
      const MyHomePage(title: ''),
      const DiscoverStoreScreen(),
      const FavoritesStoreScreen(),
      const AccountStoreScreen()
    ];
    // final bottomNavBarWatch = ref.watch(bottomNavBarProvider);

    return Scaffold(
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: pageviewItems,
      ),
    );
  }
}
