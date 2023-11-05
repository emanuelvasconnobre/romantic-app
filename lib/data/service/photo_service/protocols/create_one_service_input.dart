import 'dart:io';

class CreateOneServiceInput {
  final File image;
  final String description;
  final String originalName;
  final DateTime uploadAt;
  final double size;

  CreateOneServiceInput(
      {required this.image,
      required this.description,
      required this.originalName,
      required this.size})
      : uploadAt = DateTime.now();
}
