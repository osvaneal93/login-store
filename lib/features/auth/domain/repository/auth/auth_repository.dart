import 'package:multi_store_app/features/auth/data/models/auth_model.dart';
import 'package:multi_store_app/features/auth/domain/source/auth/auth_datasource.dart';
import 'package:multi_store_app/features/providers/auth/global_auth/global_auth_provider.dart';

abstract class AuthRepositoryBase {
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

class AuthRepository extends AuthRepositoryBase {
  final AuthDataSource dataSource;

  AuthRepository(this.dataSource);
  @override
  Future<void> userLogOut() => dataSource.userLogOut();

  @override
  Future<UserModel> userLogin(String email, String password) => dataSource.userLogin(email, password);

  @override
  Future<UserModel> userSignIn(String email, String password, String name, String lastName) =>
      dataSource.userSignIn(email, password, name, lastName);

  @override
  Future<AuthStatus> checkUserStatus() => dataSource.checkUserStatus();

  @override
  Future<UserModel> getUserModel() => dataSource.getUserModel();

  @override
  Future<void> changeUserPassword(String token) => dataSource.changeUserPassword(token);

  @override
  Future<void> sendRecoveryPasswordEmail(String email) => dataSource.sendRecoveryPasswordEmail(email);

  @override
  Future<UserModel> signInWithGoogle() => dataSource.signInWithGoogle();

  @override
  Future<UserModel> signInWithFacebook() => dataSource.signInWithFacebook();
}
