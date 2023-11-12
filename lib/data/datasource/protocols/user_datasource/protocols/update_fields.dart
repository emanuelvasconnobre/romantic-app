class UpdateOneUserDatasourceInput {
  final String name;
  final String profilePictureUrl;
  final String bio;

  UpdateOneUserDatasourceInput({
    required this.name,
    required this.profilePictureUrl,
    required this.bio,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'bio': bio,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}
