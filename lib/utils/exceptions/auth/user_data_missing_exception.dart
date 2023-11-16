import 'package:romanticapp/utils/exceptions/protocols/app_exception.dart';
import 'package:romanticapp/utils/result_helper/result.dart';

class UserDataMissingException extends AppException {
  UserDataMissingException()
      : super(
            title: 'Ocorreu um erro!',
            message: 'Não foi possível resgatar os dados deste usuário.',
            type: ResultMessageType.danger);
}
