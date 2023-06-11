import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static void initEnvironment() async {
    await dotenv.load(fileName: ".env");
  }

  static String apiUrl = dotenv.env['FIREBASE_APIKEY'] ?? '';
}
