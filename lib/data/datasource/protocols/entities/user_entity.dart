
class UserEntity {
  final String uid;
  final String userName;
  final String email;
  final String profilePictureUrl;

  UserEntity(
      {required this.uid,
        required this.email,
        required this.profilePictureUrl,
        required this.userName});

  static UserEntity getDummy() {
    return UserEntity(
        uid: "1",
        email: "email@email.com",
        profilePictureUrl: "https://profilePictureUrl.app/photo.png",
        userName: "tech tick");
  }
}