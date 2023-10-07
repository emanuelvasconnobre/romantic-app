import 'package:projects/validation/interfaces/validation.dart';

class MinLengthValidation implements Validation {
  int length;
  String fieldName;
  String message;

  MinLengthValidation(this.fieldName, this.length, {String? message}) :
        message = message ?? "O campo $fieldName não pode ter menos que $length caracteres";

  @override
  String? validate(input) {
    if (input.toString().trim().length <= length) {
      return message;
    }

    return null;
  }
}