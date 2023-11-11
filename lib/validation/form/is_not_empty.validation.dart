import 'package:ayane/validation/interfaces/validation.dart';

class IsNotEmptyValidation implements Validation {
  String fieldName;
  String message;

  IsNotEmptyValidation(this.fieldName, {String? message}) :
      message = message ?? "O campo $fieldName não pode estar vazio";

  @override
  String? validate(input) {
    if (input.toString().isEmpty) {
      return message;
    }

    return null;
  }
}