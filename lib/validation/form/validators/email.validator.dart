import 'package:projects/utils/is_email_valid.dart';
import 'package:projects/validation/form/interfaces/email.validator.dart';

class EmailValidatorImpl implements EmailValidator {
  @override
  bool isValid(String email) {
    return isEmailValid(email);
  }
}