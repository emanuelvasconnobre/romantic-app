import 'package:romanticapp/validation/form/interfaces/email.validator.dart';
import 'package:romanticapp/validation/form/validators/email.validator.dart';
import 'package:romanticapp/validation/interfaces/validation.dart';

class EmailValidation implements Validation {
  String message = "Insira um email válido!";
  EmailValidator emailValidator = EmailValidatorImpl();

  EmailValidation({EmailValidator? emailValidator}) {
    if (emailValidator != null) {
      this.emailValidator = emailValidator;
    }
  }

  @override
  String? validate(input) {
    var isValid = emailValidator.isValid(input);

    if (!isValid) {
      return message;
    }

    return null;
  }
}