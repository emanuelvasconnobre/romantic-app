import 'package:firebase_auth/firebase_auth.dart';
import 'package:projects/data/auth/protocols/authentication/authentication_module.dart';
import 'package:projects/data/auth/protocols/authentication/protocols/credential_data.dart';
import 'package:projects/data/datasource/protocols/entities/user_entity.dart';
import 'package:projects/utils/exceptions/auth/login_credentials_mismatch_exception.dart';
import 'package:projects/utils/exceptions/protocols/app_exception.dart';
import 'package:projects/utils/exceptions/unexpected_exception.dart';

class DummyAuthenticationModule implements AuthenticationModule {
  @override
  Future<CredentialData> logIn(String email, String password) async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      return CredentialData(
          user: UserEntity(
              userName: "Perfil Anônimo",
              email: "email@email.com",
              uid: "3roieagj309jaoieaejio",
              profilePictureUrl: "",
              bio: "Nothing",
              name: "Name"),
          auth: AuthData(authOptions: {
            "firebase": true,
          }));
    } on AppException {
      rethrow;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "INVALID_LOGIN_CREDENTIALS":
          throw LoginCredentialsMismatchException();
      }

      throw UnexpectedException();
    } catch (e) {
      throw UnexpectedException();
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
      throw UnexpectedException();
    }
  }
}
