import 'package:romanticapp/utils/exceptions/protocols/app_exception.dart';
import 'package:romanticapp/utils/result_helper/result.dart';

class DataNotFoundException extends AppException {
  DataNotFoundException({String? message})
      : super(
            title: 'Ocorreu um erro!',
            message: message ?? "Não foi possível achar dados",
            type: ResultMessageType.danger);
}
