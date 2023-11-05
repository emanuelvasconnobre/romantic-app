import '../../result_helper/result.dart';
import '../protocols/app_exception.dart';

class LoginCredentialsMismatchException extends AppException {
  LoginCredentialsMismatchException()
      : super(
            title: 'Credenciais inválidas!',
            message: 'Email ou senha inválidos.',
            type: ResultMessageType.danger);
}
