class UserSession {
  UserSession._();

  static final UserSession instance = UserSession._();

  String? name;
  String? phone;
  String? email;
  String? photoPath;
}
