import 'package:projects/data/auth/protocols/authentication/protocols/credential_data.dart';

abstract class AuthenticationModule {
  Future<void> logOut();

  Future<CredentialData> logIn();
}