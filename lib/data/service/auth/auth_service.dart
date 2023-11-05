import 'package:projects/data/auth/protocols/authentication/authentication_module.dart';
import 'package:projects/data/auth/protocols/authentication/protocols/credential_data.dart';
import 'package:projects/utils/result_helper/result.dart';

import '../../datasource/protocols/entities/user_entity.dart';

class AuthService {
  final AuthenticationModule authenticationModule;

  AuthService({required this.authenticationModule});

  Future<Result<CredentialData>> logIn(String email, String password) async {
    return Success(
        data: CredentialData(
            user: UserEntity.getDummy(), auth: AuthData.getDummy()));
  }
}
