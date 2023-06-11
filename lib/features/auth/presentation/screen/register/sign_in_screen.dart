import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_store_app/core/paths.dart';
import 'package:multi_store_app/core/validators.dart';
import 'package:multi_store_app/features/auth/presentation/screen/login/login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multi_store_app/features/shared/widgets/custom_dialogs.dart';
import 'package:multi_store_app/features/shared/widgets/custom_shop_elevated_button.dart';
import 'package:multi_store_app/features/shared/widgets/custom_shop_textfield.dart';
import 'package:multi_store_app/features/providers/auth/sign_in/sign_in_form_provider.dart';
import 'package:multi_store_app/features/shared/widgets/custom_social_button.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});
  static const path = "/signin";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();

    ref.listen(signInProvider, (previous, next) {
      if (previous?.isPosting == false && next.isPosting == true) {
        CustomDialogs.loadingDialog(context);
      }
      if (previous?.isPosting == true && next.isPosting == false) {
        context.pop();
      }
      if (next.errorMessage != null && next.errorMessage != '' && next.errorMessage != previous?.errorMessage) {
        CustomDialogs.errorDialog(
          context,
          next.errorMessage ?? '',
        );
      }
    });

    final signInFormRef = ref.read(signInProvider.notifier);
    final signInFormProvider = ref.watch(signInProvider);

    final screenSize = MediaQuery.of(context).size;
    final translate = AppLocalizations.of(context)!;
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: null,
        // foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomHeaderStack(),
            Form(
                key: signInFormKey,
                child: Column(
                  children: [
                    Text(
                      translate.writeYourData,
                      style: textStyle.bodyLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //-----name
                    CustomShopTextfield(
                      textInputAction: TextInputAction.next,
                      hintText: translate.name,
                      height: 60,
                      width: screenSize.width * .9,
                      controller: signInFormRef.nameSignInController,
                      icon: Icons.person,
                      onChanged: (value) => signInFormRef.onNameChange(),
                      validator: (p0) => validators.validateName(text: signInFormProvider.name ?? ''),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //-----last name
                    CustomShopTextfield(
                      textInputAction: TextInputAction.next,
                      hintText: translate.lastName,
                      height: 60,
                      width: screenSize.width * .9,
                      controller: signInFormRef.lastNameSignInController,
                      icon: Icons.person,
                      onChanged: (value) => signInFormRef.onLastNameChange(),
                      validator: (p0) => validators.validateName(text: signInFormProvider.name ?? ''),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //-----email
                    CustomShopTextfield(
                      textInputAction: TextInputAction.next,
                      hintText: translate.email,
                      height: 60,
                      width: screenSize.width * .9,
                      controller: signInFormRef.emailSignInController,
                      icon: Icons.email_outlined,
                      onChanged: (value) => signInFormRef.onEmailChange(),
                      validator: (p0) =>
                          validators.validateEmail(email: signInFormProvider.email ?? '', context: context),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //-----password
                    CustomShopTextfield(
                      onChanged: (value) => signInFormRef.onPasswordChange(),
                      autovalidateMode: signInFormProvider.isPosted ? AutovalidateMode.always : null,
                      controller: signInFormRef.passwordSignInController,
                      validator: (p0) => validators.validatePassword(password: signInFormProvider.password ?? ''),
                      icon: Icons.lock_outline,
                      hintText: translate.password,
                      height: 60,
                      width: MediaQuery.of(context).size.width * .9,
                      isPassword: true,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //---- confirm pass
                    CustomShopTextfield(
                      onChanged: (value) => signInFormRef.onConfirmPasswordChange(),
                      controller: signInFormRef.passwordConfirmController,
                      validator: (p0) => validators.confirmPassword(
                          pass: signInFormProvider.password ?? '',
                          confirmPass: signInFormProvider.confirmPassword ?? ''),
                      icon: Icons.lock_outline,
                      hintText: translate.confirmPassword,
                      height: 60,
                      width: MediaQuery.of(context).size.width * .9,
                      isPassword: true,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomShopElevatedButton(
                      color: Colors.amber,
                      buttonSize: ButtonSize.medium,
                      label: translate.signUp,
                      onPressed: () {
                        signInFormKey.currentState!.validate()
                            ? signInFormRef.onSubmmitSignInButton()
                            : debugPrint('CAMPOS INVALIDOS');
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      translate.or,
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
                            signInFormRef.onSubmmitFacebookButton();
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CustomSocialButton(
                          child: Image.asset(paths.googleLogo, height: 35),
                          onPressed: () {
                            signInFormRef.onSubmmitGoogleButton();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(translate.youHaveAccount),
                        const SizedBox(
                          width: 5,
                        ),
                        CustomTextButtonStore(
                          onTap: () => context.pushReplacement(LoginScreen.path),
                          text: translate.signIn,
                          textColor: Colors.amber,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
