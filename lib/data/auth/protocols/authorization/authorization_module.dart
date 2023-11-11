import 'package:ayane/data/auth/protocols/authentication/protocols/credential_data.dart';

abstract class AuthorizationModule {
  Future<CredentialData> logInWithToken();

  Future<void> refreshAccess();
}