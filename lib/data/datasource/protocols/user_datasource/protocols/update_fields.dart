class UpdateOneUserDatasourceInput {
  String? profilePictureUrl;
  String? name;
  String? bio;

  UpdateOneUserDatasourceInput({
    this.profilePictureUrl,
    this.name,
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
