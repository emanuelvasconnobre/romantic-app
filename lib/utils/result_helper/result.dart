import 'package:projects/utils/exceptions/protocols/app_exception.dart';

enum ResultMessageType { danger, success, warning, info }

extension ResultMessageTypeExtension on ResultMessageType {
  String get name {
    switch (this) {
      case ResultMessageType.danger:
        return 'DANGER';
      case ResultMessageType.success:
        return 'SUCCESS';
      case ResultMessageType.warning:
        return 'WARNING';
      case ResultMessageType.info:
        return 'INFO';
      default:
        return '';
    }
  }
}

class ResultMessage {
  final String title;
  final String message;
  final ResultMessageType type;

  ResultMessage(
      {required this.title, required this.message, required this.type});
}

abstract class Result<D> {
  final AppException? exception;
  final ResultMessage message;
  final DateTime createdAt;
  final D? data;

  Result({required this.message, this.data, this.exception})
      : createdAt = DateTime.now();
}

class Success<D> extends Result<D> {
  Success({ResultMessage? message, required D data})
      : super(
            message: message ??
                ResultMessage(
                    title: "Sucesso!",
                    message: "Operação realizada com sucesso.",
                    type: ResultMessageType.success),
            data: data);
}

class Failure extends Result {
  Failure(AppException exception)
      : super(message: exception.getResultMessage(), exception: exception);
}
