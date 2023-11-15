class UpdateOneUserDatasourceInput {
  String? name;
  String? profilePictureUrl;
  String? bio;

  UpdateOneUserDatasourceInput({
    this.name,
    this.profilePictureUrl,
    this.bio,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'bio': bio,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}
