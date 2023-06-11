import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_store_app/core/paths.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multi_store_app/core/validators.dart';
import 'package:multi_store_app/features/auth/presentation/screen/recovery_password/email_sended.dart';
import 'package:multi_store_app/features/shared/widgets/custom_dialogs.dart';
import 'package:multi_store_app/features/shared/widgets/custom_shop_elevated_button.dart';
import 'package:multi_store_app/features/shared/widgets/custom_shop_textfield.dart';
import 'package:multi_store_app/features/providers/auth/recovery_password/recovery_password_form_provider.dart';

class RecoveryPasswordScreen extends ConsumerStatefulWidget {
  static const String path = '/recovery-password';
  const RecoveryPasswordScreen({super.key});

  @override
  RecoveryPasswordScreenState createState() => RecoveryPasswordScreenState();
}

class RecoveryPasswordScreenState extends ConsumerState {
  @override
  Widget build(
    BuildContext context,
  ) {
    final translate = AppLocalizations.of(context)!;
    final textStyle = Theme.of(context).textTheme;
    final screenSize = MediaQuery.of(context).size;
    final recoveryPasswordRef = ref.read(recoveryPasswordFormProvider.notifier);
    final recoveryPasswordProvider = ref.watch(recoveryPasswordFormProvider);
    ref.listen(recoveryPasswordFormProvider, (previous, next) {
      if (next.sending == true) {
        CustomDialogs.loadingDialog(context);
      }
      if (previous?.sending == true && next.sending == false) {
        context.pop();
      }
      if (next.sended == true) {
        context.pushReplacement(EmailSendedScreen.path);
      }
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
        title: Text(
          translate.forgotPassword,
          style: textStyle.bodyLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(minWidth: screenSize.width, minHeight: screenSize.height - 60),
          child: Column(
            children: [
              Form(
                key: recoveryPasswordRef.recoveryFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      paths.forgotPasswordImage,
                      // height: screenSize.height * .4,
                      width: screenSize.width * .7,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      translate.passwordRecovery,
                      style: textStyle.headlineSmall,
                    ),
                    Text(
                      translate.enterEmailRecovery,
                      style: textStyle.bodyMedium,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomShopTextfield(
                      onChanged: (p0) => recoveryPasswordRef.onEmailChange(),
                      controller: recoveryPasswordRef.emailRecoveryController,
                      textInputAction: TextInputAction.done,
                      hintText: translate.email,
                      icon: Icons.mark_email_read_outlined,
                      validator: (p0) =>
                          validators.validateEmail(email: recoveryPasswordProvider.email ?? '', context: context),
                      height: 60,
                      width: screenSize.width * .9,
                    ),
                    CustomShopElevatedButton(
                      color: Colors.amber,
                      onPressed: () {
                        recoveryPasswordRef.recoveryFormKey.currentState!.validate()
                            ? recoveryPasswordRef.onSubmmitButton()
                            : null;
                      },
                      label: translate.next,
                    ),
                  ],
                ),
              ),
              Text(recoveryPasswordProvider.errorMessage ?? '-')
            ],
          ),
        ),
      ),
    );
  }
}
