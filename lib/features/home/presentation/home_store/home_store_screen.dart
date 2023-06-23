import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/core/paths.dart';
import 'package:multi_store_app/features/auth/data/models/product_model.dart';
import 'package:multi_store_app/features/home/presentation/home_store/widgets/count_down_clock.dart';
import 'package:multi_store_app/features/home/presentation/home_store/widgets/custom_banner_container.dart';
import 'package:multi_store_app/features/home/presentation/home_store/widgets/custom_container_sliver.dart';
import 'package:multi_store_app/features/home/presentation/home_store/widgets/custom_model_container.dart';
import 'package:multi_store_app/features/home/presentation/home_store/widgets/custom_products_scroll.dart';
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
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    final translate = AppLocalizations.of(context)!;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: translate.home,
        ),
        BottomNavigationBarItem(icon: Icon(Icons.home_mini), label: translate.discover),
        BottomNavigationBarItem(icon: Icon(Icons.heart_broken), label: translate.favorites),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: translate.account),
      ]),
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
          SliverList.list(
            children: [
              const SizedBox(
                height: 20,
              ),
              const CustomScrollingHelper(),
              const SizedBox(
                height: 20,
              ),
              CustomModelContainer(
                labelButton: translate.shopNow,
                imagePath: paths.womanModel,
                title: '${translate.news} ${translate.arrival}',
                subtitle: translate.withFreeShipping,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomProductsScroll(
                  widgetLabel: Text(translate.popularProducts,
                      style: textStyle.headlineSmall!.copyWith(fontWeight: FontWeight.w900)),
                  productList: [
                    ProductModel(
                      brand: 'Armani',
                      name: 'Vestido de color variosssssssssssssssssssssssssssssssssssss',
                      price: 25,
                    ),
                    ProductModel(
                      brand: 'Armani',
                      name: 'Vestido de color varios',
                      price: 25,
                    ),
                    ProductModel(
                      brand: 'Armani',
                      name: 'Vestido de color varios',
                      price: 25,
                    ),
                    ProductModel(
                      brand: 'Armani',
                      name: 'Vestido de color varios',
                      price: 25,
                    ),
                    ProductModel(
                      brand: 'Armani',
                      name: 'Vestido de color varios',
                      price: 25,
                    ),
                    ProductModel(
                      brand: 'Armani',
                      name: 'Vestido de color varios',
                      price: 25,
                    ),
                    ProductModel(
                      brand: 'Armani',
                      name: 'Vestido de color varios',
                      price: 25,
                    ),
                    ProductModel(
                      brand: 'Armani',
                      name: 'Vestido de color varios',
                      price: 25,
                    ),
                  ]),
              const SizedBox(
                height: 20,
              ),
              CustomBannerContainer(
                imageBannerPath: paths.arianaBanner,
                title: translate.flashSale,
                subtitle: '${translate.upTo} 40%',
              ),
              CustomProductsScroll(
                  widgetLabel: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        translate.flashSale,
                        style: textStyle.headlineSmall!.copyWith(fontWeight: FontWeight.w900),
                      ),
                      const Spacer(),
                      CountdownClock(countdownDuration: 1000000)
                    ],
                  ),
                  productList: [
                    ProductModel(brand: 'Armani', name: 'Vestido de color variossssss', price: 25, discount: 20),
                    ProductModel(brand: 'Armani', name: 'Vestido de color varios', price: 25),
                    ProductModel(brand: 'Armani', name: 'Vestido de color varios', price: 25, discount: 10),
                    ProductModel(brand: 'Armani', name: 'Vestido de color varios', price: 25),
                    ProductModel(brand: 'Armani', name: 'Vestido de color varios', price: 25),
                    ProductModel(brand: 'Armani', name: 'Vestido de color varios', price: 25),
                    ProductModel(brand: 'Armani', name: 'Vestido de color varios', price: 25),
                    ProductModel(brand: 'Armani', name: 'Vestido de color varios', price: 25),
                  ]),
              CustomBannerContainer(
                imageBannerPath: paths.modelsKids,
                title: translate.knockOutDeals,
                onTap: () {},
                buttonLabel: translate.shopNow,
              ),
            ],
          ),
        ],
      )),
    );
  }
}
