import 'package:projects/data/auth/protocols/authentication/protocols/credential_data.dart';

abstract class AuthenticationModule {
  Future<CredentialData> logIn(String email, String password);

  Future<void> logOut();
}