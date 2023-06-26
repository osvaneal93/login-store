import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multi_store_app/core/constants/environment.dart';
import 'package:multi_store_app/firebase_options.dart';
import 'package:multi_store_app/l10n/l10n.dart';
import 'package:multi_store_app/features/providers/notifications/push_notifications_provider.dart';
import 'package:multi_store_app/settings/flavors_environment/enviroment.dart';
import 'package:multi_store_app/settings/local_notifications/local_notifications_config.dart';
import 'package:multi_store_app/settings/preferences/preferences_config.dart';
import 'package:multi_store_app/settings/routes/router.dart';
import 'package:multi_store_app/settings/theme/theme_provider.dart';
import 'package:multi_store_app/settings/theme/theme_setings.dart';

late final FlavorEnvironment flavorEnvironment;
late final FirebaseAuth globalyAuth;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  int generarNumeroRandom() {
    Random random = Random();
    int numero = random.nextInt(9000) + 1000; // Genera un número entre 1000 y 9999
    return numero;
  }

  if (message.data.isEmpty) return;
  LocalNotifications.showLocalNotification(
      id: generarNumeroRandom(),
      title: message.data['title'] ?? "",
      body: message.data['body'] ?? "",
      channelId: message.data['channelId'] ?? "");
}

void mainApp(FlavorEnvironment env) async {
  WidgetsFlutterBinding.ensureInitialized();
  Environment.initEnvironment();
  await Preferences.init();
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  globalyAuth = FirebaseAuth.instanceFor(app: app);

  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  await LocalNotifications.initializeLocalNotifications();
  await NotificationsProvider.initializeFCM();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  flavorEnvironment = env;
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeController = ref.watch(themeNotifierProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: L10n.all,
        title: 'Flutter Demo',
        theme: ThemeDataMutiStore(colorSeed: themeController.colorSeed, isDarkMode: themeController.isDarkMode)
            .getThemeData(),
        routerConfig: ref.watch(routeProvider),
      ),
    );
  }
}
