import 'package:multi_store_app/features/auth/data/models/auth_model.dart';

class AuthMappers {
  static UserModel firebaseUserJsonToEntity(Map<String, dynamic> json) => UserModel(
      userId: json['uid'],
      email: json['email'],
      name: json['name'],
      lastName: json['lastName'],
      // token: json['token'],
      roles: List.from(json['roles']).map((e) {
        if (e is String) {
          return e;
        } else {
          return '';
        }
      }).toList());
}
