import 'package:ayane/data/auth/dummy/dummy_authentication_module.dart';
import 'package:ayane/data/auth/firebase/firebase_authentication_module.dart';
import 'package:ayane/data/service/auth/auth_service.dart';

class AuthServiceFactory {
  static AuthService? authServiceInstance;

  static AuthService getInstance() {
    return AuthServiceFactory.getInstanceFromFirebase();
  }

  static AuthService getInstanceFromFirebase() {
    AuthService instance =
        AuthService(authenticationModule: FirebaseAuthenticationModule());

    AuthServiceFactory.authServiceInstance = instance;

    return instance;
  }

  static AuthService getInstanceFromDummy() {
    AuthService instance =
        AuthService(authenticationModule: DummyAuthenticationModule());

    AuthServiceFactory.authServiceInstance = instance;

    return instance;
  }
}
