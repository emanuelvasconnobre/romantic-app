import 'package:romanticapp/utils/result_helper/result.dart';

class AppException implements Exception {
  final String message;
  final String title;
  final String? stack;
  final List<String> issues;
  final ResultMessageType? type;

  AppException(
      {required this.title,
      required this.message,
      this.stack,
      List<String>? issues,
      this.type})
      : issues = issues ?? [];

  getResultMessage() {
    final definedType = type ?? ResultMessageType.danger;

    return ResultMessage(
      title: title,
      message: message,
      type: definedType,
    );
  }
}
