class UserModel {
  final String? name, lastName, email, userId, token;
  final List<String>? roles;

  UserModel({this.name, this.lastName, this.email, this.userId, this.token, this.roles});

  UserModel copyWith(
          {String? name, String? lastName, String? email, String? userId, String? token, List<String>? roles}) =>
      UserModel(
          email: email ?? this.email,
          lastName: lastName ?? this.lastName,
          name: name ?? this.name,
          userId: userId ?? this.userId,
          token: token ?? this.token,
          roles: roles ?? this.roles);

  bool get isAdmin => roles?.contains('admin') ?? false;
}
