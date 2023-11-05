import 'package:projects/data/datasource/protocols/entities/user_entity.dart';

class AuthData<T extends Object> {
  final String? accessToken;
  final String? refreshToken;
  final String? bearerToken;
  final T? authOptions;

  AuthData(
      {this.accessToken,
      this.refreshToken,
      this.bearerToken,
      this.authOptions});

  static AuthData getDummy() {
    return AuthData(
        accessToken: "kgaowek23goalkm3oi4j123",
        refreshToken: "3o2k41oi5j12o31234opk412",
        bearerToken: "1po23kp412po43po");
  }
}

class CredentialData {
  String? get userId => user?.uid;
  UserEntity? user;
  AuthData? auth;

  CredentialData({this.auth, this.user});
}
