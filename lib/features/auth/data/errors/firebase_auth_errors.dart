import 'package:firebase_auth/firebase_auth.dart';
//-----------Register

class UserNotFound extends FirebaseAuthException {
  UserNotFound({required super.code});
}
