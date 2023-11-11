import 'package:ayane/data/datasource/protocols/entities/user_entity.dart';
import 'package:ayane/utils/exceptions/intance_exception.dart';
import 'package:ayane/utils/exceptions/protocols/app_exception.dart';

class PhotoEntity {
  String id;
  String imageUrl;
  String description;
  String originalName;
  String fileName;
  DateTime uploadAt;
  double size;
  String userId;
  UserEntity user;

  PhotoEntity(
      {required this.id,
      required this.imageUrl,
      required this.description,
      required this.originalName,
      required this.fileName,
      required this.uploadAt,
      required this.size,
      required this.userId,
      required this.user});

  factory PhotoEntity.fromMap(Map<String, dynamic> map) {
    try {
      return PhotoEntity(
        id: map['id'],
        imageUrl: map['imageUrl'],
        description: map['description'],
        originalName: map['originalName'],
        fileName: map['fileName'],
        uploadAt: DateTime.parse(map['uploadAt']),
        size: map['size'],
        userId: map['userId'],
        user: UserEntity.fromMap(map['user']),
      );
    } on AppException catch (_) {
      rethrow;
    } catch (e) {
      throw InstanceException("PhotoEntity");
    }
  }

  static getDummy() {
    return PhotoEntity(
        id: "id",
        imageUrl: "imageUrl",
        description: "description",
        originalName: "originalName",
        fileName: "fileName",
        uploadAt: DateTime.now(),
        size: 1.2,
        userId: "userId",
        user: UserEntity.getDummy());
  }
}
