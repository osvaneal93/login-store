import 'package:multi_store_app/features/auth/data/models/auth_model.dart';
import 'package:multi_store_app/features/providers/auth/global_auth/global_auth_provider.dart';

abstract class AuthDataSource {
  Future<UserModel> userLogin(String email, String password);
  Future<UserModel> userSignIn(String email, String password, String name, String lastName);

  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithFacebook();

  Future<UserModel> getUserModel();
  Future<AuthStatus> checkUserStatus();
  Future<void> sendRecoveryPasswordEmail(String email);
  Future<void> changeUserPassword(String token);
  Future<void> userLogOut();
}
