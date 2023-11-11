import 'package:ayane/data/auth/protocols/authentication/authentication_module.dart';
import 'package:ayane/data/auth/protocols/authentication/protocols/credential_data.dart';
import 'package:ayane/utils/exceptions/protocols/app_exception.dart';
import 'package:ayane/utils/exceptions/unexpected_exception.dart';
import 'package:ayane/utils/result_helper/result.dart';

class AuthService {
  final AuthenticationModule authenticationModule;

  AuthService({required this.authenticationModule});

  Future<Result<CredentialData>> logIn(String email, String password) async {
    try {
      final credentialData = await authenticationModule.logIn(email, password);

      return Success(data: credentialData);
    } on AppException catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(UnexpectedException());
    }
  }

  Future<Result<void>> logOut() async {
    try {
      await authenticationModule.logOut();

      return Success(data: null);
    } on AppException catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(UnexpectedException());
    }
  }
}
