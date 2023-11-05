import 'package:projects/data/auth/firebase/firebase_authentication_module.dart';
import 'package:projects/data/service/auth/auth_service.dart';

class AuthServiceFactory {
  static AuthService? authServiceInstance;

  static AuthService getInstanceFromFirebase() {
    AuthService instance = AuthService(authenticationModule: FirebaseAuthenticationModule());

    AuthServiceFactory.authServiceInstance = instance;

    return instance;
  }
}