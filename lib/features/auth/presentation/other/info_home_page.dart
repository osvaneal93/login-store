import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/features/shared/widgets/custom_shop_elevated_button.dart';
import 'package:multi_store_app/features/providers/auth/global_auth/global_auth_provider.dart';
import 'package:multi_store_app/settings/theme/theme_provider.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});
  static const String path = '/';

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProviderRef = ref.read(authStateProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomShopElevatedButton(
                  color: Colors.black,
                  onPressed: () => authProviderRef.userLogout(),
                )

                ///------------------------------------------------------------------------------------

                //////////---------Composited sirve para poder anclar un wiget a otro---------------
                ///------de acuerdo a la posición actual, se puede utilizar para los
                ///-----------floatingDropdownBox
                // final LayerLink _layerLink = LayerLink();

                // CompositedTransformTarget(
                //   link: _layerLink,
                //   child: Text(
                //     'NOMBRE DEVELOPER: ${flavorEnvironment.devName}',
                //   ),
                // ),
                // CompositedTransformFollower(
                //   link: _layerLink,
                //   offset: Offset(0, 0),
                //   child: Container(
                //     height: 100,
                //     width: 100,
                //     decoration: BoxDecoration(color: Colors.red.withOpacity(.2)),
                //   ),
                // ),
                //------------------------------------------
                ///////--------------------------------------------------------------------------------
                ///------------------------------------------------------------------------------------
                // Text(
                //   'API KEY TOKEN: ${flavorEnvironment.apiKey}',
                // ),
                // Text(
                //   '0',
                //   style: Theme.of(context).textTheme.headlineMedium,
                // ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(themeNotifierProvider.notifier).toggleDarkMode();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
