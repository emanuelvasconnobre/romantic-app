import 'dart:io';

class UpdateProfileUserServiceInput {
  final File profilePicture;
  final String name;
  final String bio;

  UpdateProfileUserServiceInput(
      {required this.profilePicture, required this.name, required this.bio});
}
