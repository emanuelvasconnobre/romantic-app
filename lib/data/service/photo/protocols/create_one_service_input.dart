import 'dart:io';

class CreateOneServiceInput {
  final File image;
  final String description;
  final String userId;

  CreateOneServiceInput(
      {required this.image, required this.description, required this.userId});
}
