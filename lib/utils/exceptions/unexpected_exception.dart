import 'package:romanticapp/utils/exceptions/protocols/app_exception.dart';
import 'package:romanticapp/utils/result_helper/result.dart';

class UnexpectedException extends AppException {
  UnexpectedException()
      : super(
            title: 'Ocorreu um erro!',
            message: 'Ocorreu um erro inesperado.',
            type: ResultMessageType.danger);
}
