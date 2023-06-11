import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_store_app/core/paths.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multi_store_app/features/auth/presentation/screen/login/login_screen.dart';

import 'package:multi_store_app/features/shared/widgets/custom_shop_elevated_button.dart';

class EmailSendedScreen extends ConsumerWidget {
  static const String path = '/email-sended';
  const EmailSendedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final translate = AppLocalizations.of(context)!;
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              paths.emailSended,
              width: screenSize.width * .75,
            ),
            const SizedBox(
              height: 60,
            ),
            Text(
              translate.emailSendedDone,
              style: textStyle.headlineSmall,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
              child: Text(
                translate.emailSended,
                style: textStyle.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            CustomShopElevatedButton(
              color: Colors.amber,
              label: translate.backToLogin,
              buttonSize: ButtonSize.medium,
              onPressed: () => context.pushReplacement(LoginScreen.path),
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
