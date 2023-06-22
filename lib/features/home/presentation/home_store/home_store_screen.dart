import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/core/paths.dart';
import 'package:multi_store_app/features/home/presentation/home_store/widgets/custom_container_sliver.dart';
import 'package:multi_store_app/features/home/presentation/home_store/widgets/custom_scrolling_row/custom_scrolling_row.dart';
import 'package:multi_store_app/features/home/presentation/home_store/widgets/custom_sliver_textfiled.dart';
import 'package:multi_store_app/features/home/presentation/home_store/widgets/flexible_header.dart';
import 'package:multi_store_app/features/home/presentation/home_store/widgets/headers_slivers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import 'package:multi_store_app/features/shared/widgets/custom_shop_elevated_button.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});
  static const String path = '/';
  final String title;
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends ConsumerState {
  @override
  void initState() {
    // bloc.init();
    super.initState();
  }

  @override
  void dispose() {
    // bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;

    return Scaffold(
      body: Scrollbar(
          child: CustomScrollView(
        // controller: bloc.scrollControllerGlobally,
        slivers: [
          FlexibleSpaceBarHeader(
            backgroundImage: Image.asset(
              paths.modelsHeader,
              fit: BoxFit.cover,
            ),
            leftIcon: Icons.menu,
            rightIcon: Icons.notifications,
          ),
          SliverPersistentHeader(
            delegate: HeaderSlivers(
                avatarPath: 'https://qph.cf2.quoracdn.net/main-qimg-6a429ab1501b09dce408fd2e7e26629f-lq',
                icon: Icons.notifications,
                label: translate.deliverTo,
                subIcon: Icons.shopping_cart,
                subtitle: translate.home,
                terciaryicon: Icons.star,
                terciaryText: '123 Likes'),
            pinned: true,
          ),
          SliverPersistentHeader(
            delegate:
                CustomSliverTextfield(onHeaderChange: (bool visible) {}, hintText: 'Search', suffixIcon: Icons.search),
          ),
          SliverPersistentHeader(
            delegate: CustomScrollingRow(),
          ),
          ...List.generate(
            6,
            (index) => SliverPersistentHeader(
                delegate: ContainerSlivers(onHeaderChange: (visible) {}
                    //  (visible) => bloc.refreshHeader(
                    //   index,
                    //   visible,
                    //   lastIndex: index > 0 ? index - 1 : null,
                    // ),
                    )),
          )
        ],
      )),
    );
  }
}
