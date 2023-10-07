import 'package:projects/validation/interfaces/validation.dart';

class CompositeValidation implements Validation {
  List<Validation> validations;

  CompositeValidation(this.validations);

  @override
  String? validate(input) {
    for (var validation in validations) {
      var message = validation.validate(input);

      if (message != null) {
        return message;
      }
    }

    return null;
  }

}