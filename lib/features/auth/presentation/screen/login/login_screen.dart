import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_store_app/core/validators.dart';
import 'package:multi_store_app/features/auth/presentation/screen/recovery_password/recovery_passsword_screen.dart';
import 'package:multi_store_app/features/auth/presentation/screen/register/sign_in_screen.dart';
import 'package:multi_store_app/features/shared/widgets/custom_dialogs.dart';
import 'package:multi_store_app/features/shared/widgets/custom_painter/header_login_cp.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multi_store_app/features/shared/widgets/custom_shop_elevated_button.dart';
import 'package:multi_store_app/features/shared/widgets/custom_shop_textfield.dart';
import 'package:multi_store_app/features/shared/widgets/custom_social_button.dart';
import 'package:multi_store_app/core/paths.dart';
import 'package:multi_store_app/features/providers/auth/login/login_form_providers.dart';

class LoginScreen extends ConsumerWidget {
  static const path = "/login";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

    final traductions = AppLocalizations.of(context)!;
    final loginProviderRef = ref.watch(loginFormNotifierProvider);
    final loginNotifier = ref.read(loginFormNotifierProvider.notifier);

    ref.listen(loginFormNotifierProvider, (previous, next) {
      if (previous?.isPosting == true && next.isPosting == false) {
        context.pop();
      }
      if (previous?.isPosting == false && next.isPosting == true) {
        CustomDialogs.loadingDialog(context);
      }
      if (next.errorMessage != null && next.errorMessage != '') {
        CustomDialogs.errorDialog(
          context,
          next.errorMessage ?? '',
        );
      }
    });
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const CustomHeaderStack(),
          Form(
              // autovalidateMode: AutovalidateMode.always,
              key: loginFormKey,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      traductions.welcome,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.amber
                              : Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      textAlign: TextAlign.center,
                      traductions.signInTo,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomShopTextfield(
                    onChanged: (value) => loginNotifier.onEmailChange(),
                    autovalidateMode: loginProviderRef.isFormPosted ? AutovalidateMode.always : null,
                    controller: loginNotifier.emailLoginController,
                    validator: (p0) => validators.validateEmail(email: loginProviderRef.email ?? '', context: context),
                    icon: Icons.email_outlined,
                    hintText: traductions.email,
                    height: 60,
                    width: MediaQuery.of(context).size.width * .9,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  CustomShopTextfield(
                    onChanged: (value) => loginNotifier.onPasswordChange(),
                    autovalidateMode: loginProviderRef.isFormPosted ? AutovalidateMode.always : null,
                    controller: loginNotifier.passwordLoginController,
                    validator: (p0) => validators.validatePassword(password: loginProviderRef.password ?? ''),
                    icon: Icons.lock_outline,
                    hintText: traductions.password,
                    height: 60,
                    width: MediaQuery.of(context).size.width * .9,
                    isPassword: true,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  InkWell(
                    onTap: () => context.push(RecoveryPasswordScreen.path),
                    child: Text(
                      traductions.forgotPassword,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomShopElevatedButton(
                    color: Colors.amber,
                    onPressed: () {
                      loginFormKey.currentState!.validate()
                          ? ref.read(loginFormNotifierProvider.notifier).onSubmmitloginButton()
                          : debugPrint('CAMPOS INVALIDOS');
                    },
                    buttonSize: ButtonSize.large,
                    label: traductions.signIn,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    traductions.or,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomSocialButton(
                        child: Image.asset(paths.facebookLogo, height: 35),
                        onPressed: () {
                          loginNotifier.onSubmmitFacebookButton();
                        },
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      CustomSocialButton(
                        child: Image.asset(paths.googleLogo, height: 35),
                        onPressed: () {
                          loginNotifier.onSubmmitGoogleButton();
                        },
                      ),
                    ],
                  ),
                ],
              )),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(traductions.needCreate),
              const SizedBox(
                width: 5,
              ),
              CustomTextButtonStore(
                onTap: () => context.push(SignInScreen.path),
                text: traductions.signUp,
                textColor: Colors.amber,
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    ));
  }
}

class CustomTextButtonStore extends StatelessWidget {
  const CustomTextButtonStore({
    super.key,
    required this.text,
    this.onTap,
    this.textColor = Colors.black,
  });

  final String text;
  final void Function()? onTap;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: textColor, decoration: TextDecoration.underline, decorationColor: textColor),
      ),
    );
  }
}

class LoginCustomPaint extends StatelessWidget {
  const LoginCustomPaint({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(),
      size: Size.fromHeight(MediaQuery.of(context).size.height * .4),
    );
  }
}

class CustomHeaderStack extends StatelessWidget {
  const CustomHeaderStack({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          const LoginCustomPaint(),
          Center(
            child: SizedBox(
                height: MediaQuery.of(context).size.height * .4,
                child: SvgPicture.asset(
                  paths.timLogo,
                  height: 250,
                )),
          ),
        ],
      ),
    );
  }
}
