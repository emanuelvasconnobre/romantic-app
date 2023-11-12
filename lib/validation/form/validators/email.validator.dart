import 'package:romanticapp/utils/is_email_valid.dart';
import 'package:romanticapp/validation/form/interfaces/email.validator.dart';

class EmailValidatorImpl implements EmailValidator {
  @override
  bool isValid(String email) {
    return isEmailValid(email);
  }
}