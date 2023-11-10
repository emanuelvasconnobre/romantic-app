import 'package:projects/utils/exceptions/protocols/app_exception.dart';
import 'package:projects/utils/result_helper/result.dart';

class InstanceException extends AppException {
  InstanceException(
      String className
      )
      : super(
      title: 'Ocorreu um erro!',
      message: '$className: Não foi possível criar instância.',
      type: ResultMessageType.danger);
}
