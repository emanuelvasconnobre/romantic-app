import 'package:romanticapp/utils/exceptions/intance_exception.dart';
import 'package:romanticapp/utils/exceptions/protocols/app_exception.dart';

class UserEntity {
  String uid;
  String userName;
  String name;
  String email;
  String profilePictureUrl;
  String bio;

  UserEntity(
      {required this.uid,
      required this.email,
      required this.profilePictureUrl,
      required this.userName,
      required this.name,
      required this.bio});

  UserEntity.copy(UserEntity other)
      : uid = other.uid,
        email = other.email,
        profilePictureUrl = other.profilePictureUrl,
        userName = other.userName,
        name = other.name,
        bio = other.bio;

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    try {
      return UserEntity(
        uid: map['uid'],
        email: map['email'],
        profilePictureUrl: map['profilePictureUrl'],
        userName: map['userName'],
        name: map['name'],
        bio: map['bio'],
      );
    } on AppException catch (_) {
      rethrow;
    } catch (e) {
      throw InstanceException("UserEntity");
    }
  }

  static UserEntity getDummy() {
    return UserEntity(
        uid: "1",
        email: "email@email.com",
        profilePictureUrl:
            "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Senna_26.jpg",
        userName: "tech_tick",
        name: "Tech Tick",
        bio: "Hi! My name is Teck Tick. Nice to meet you!");
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
      'userName': userName,
      'name': name,
      'bio': bio,
    };
  }
}
