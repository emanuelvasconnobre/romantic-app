import 'package:firebase_auth/firebase_auth.dart';
import 'package:ayane/data/auth/protocols/authentication/authentication_module.dart';
import 'package:ayane/data/auth/protocols/authentication/protocols/credential_data.dart';
import 'package:ayane/data/datasource/protocols/entities/user_entity.dart';
import 'package:ayane/utils/exceptions/auth/login_credentials_mismatch_exception.dart';
import 'package:ayane/utils/exceptions/protocols/app_exception.dart';
import 'package:ayane/utils/exceptions/unexpected_exception.dart';

class FirebaseAuthenticationModule implements AuthenticationModule {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<CredentialData> logIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User user = result.user!;

      return CredentialData(
          user: UserEntity(
              userName: user.displayName ?? "Perfil Anônimo",
              email: user.email!,
              uid: user.uid,
              profilePictureUrl: user.photoURL ?? "",
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
      await _auth.signOut();
    } catch (e) {
      throw UnexpectedException();
    }
  }
}
