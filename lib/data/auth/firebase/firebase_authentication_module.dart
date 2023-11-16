import 'package:firebase_auth/firebase_auth.dart';
import 'package:romanticapp/data/auth/protocols/authentication/authentication_module.dart';
import 'package:romanticapp/data/auth/protocols/authentication/protocols/credential_data.dart';
import 'package:romanticapp/factories/services/user_service_factory.dart';
import 'package:romanticapp/utils/exceptions/auth/login_credentials_mismatch_exception.dart';
import 'package:romanticapp/utils/exceptions/protocols/app_exception.dart';
import 'package:romanticapp/utils/exceptions/unexpected_exception.dart';
import 'package:romanticapp/utils/result_helper/result.dart';

import '../../service/user/user_service.dart';

class FirebaseAuthenticationModule implements AuthenticationModule {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService userService = UserServiceFactory.getInstanceFromFirebase();

  @override
  Future<CredentialData> logIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User user = result.user!;

      var getProfileResult = await userService.getProfile(user.uid);

      if (getProfileResult is Failure) {
          throw getProfileResult.exception!;
      }

      return CredentialData(
          user: getProfileResult.data,
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
