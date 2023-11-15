import 'dart:io';

class UpdateProfileUserServiceInput {
  final File? profilePicture;
  final String? name;
  final String? bio;

  UpdateProfileUserServiceInput({this.profilePicture, this.name, this.bio});

  Map<String, dynamic> toMap() {
    return {
      'profilePicture': profilePicture,
      'name': name,
      'bio': bio,
    };
  }
}
