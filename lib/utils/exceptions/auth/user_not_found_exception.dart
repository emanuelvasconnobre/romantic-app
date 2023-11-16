import 'package:romanticapp/utils/exceptions/protocols/app_exception.dart';
import 'package:romanticapp/utils/result_helper/result.dart';

class UserNotFoundException extends AppException {
  UserNotFoundException()
      : super(
      title: 'Ocorreu um erro!',
      message: 'Usuário não encontrado.',
      type: ResultMessageType.danger);
}
