import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:romanticapp/data/datasource/protocols/entities/photo_entity.dart';
import 'package:romanticapp/data/datasource/protocols/entities/user_entity.dart';
import 'package:romanticapp/data/datasource/protocols/photo_datasource/photo_datasource.dart';
import 'package:romanticapp/data/datasource/protocols/photo_datasource/protocols/create_fields.dart';
import 'package:romanticapp/data/datasource/protocols/photo_datasource/protocols/update_fields.dart';
import 'package:romanticapp/utils/exceptions/auth/user_not_found_exception.dart';
import 'package:romanticapp/utils/exceptions/intance_exception.dart';
import 'package:romanticapp/utils/exceptions/protocols/app_exception.dart';
import 'package:romanticapp/utils/exceptions/unexpected_exception.dart';
import 'package:romanticapp/utils/paginated_generic_type.dart';

class FirebasePhotoDatasource implements PhotoDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<PhotoEntity> createOne(CreateOneDatasourceInput input) async {
    try {
      var newEntity = await firestore.collection("photos").add(input.toMap());
      var user = await firestore.collection("users").doc(input.userId).get();

      if (user.exists) {
        return PhotoEntity(
            id: newEntity.id,
            imageUrl: input.imageUrl,
            description: input.description,
            originalName: input.originalName,
            fileName: input.fileName,
            uploadAt: input.uploadAt,
            size: input.size,
            userId: input.userId,
            user: UserEntity(
                name: user["name"],
                userName: user["userName"],
                bio: user["bio"],
                profilePictureUrl: user["profilePictureUrl"],
                uid: input.userId,
                email: user["email"]));
      } else {
        throw UserNotFoundException();
      }
    } on AppException catch (_) {
      rethrow;
    } catch (e) {
      throw UnexpectedException();
    }
  }

  @override
  Future<void> deleteOne(String id) async {
    try {
      await firestore.collection("photos").doc(id).delete();
    } on AppException catch (_) {
      rethrow;
    } catch (e) {
      throw UnexpectedException();
    }
  }

  @override
  Future<PhotoEntity?> getById(String id) async {
    try {
      var entity = await firestore.collection("photos").doc(id).get();
      Map<String, dynamic>? data = entity.data();

      var user = await firestore.collection("users").doc(data?["userId"]).get();
      Map<String, dynamic>? userData = user.data();

      if (data == null || userData == null) {
        return null;
      }

      return PhotoEntity.fromMap({
        "id": entity.id,
        ...data,
        "user": {"uid": user.id, ...userData}
      });
    } on InstanceException catch (e) {
      if (kDebugMode) {
        print("InstanceException: $e");
      }
      return null;
    } on AppException catch (_) {
      rethrow;
    } catch (e) {
      throw UnexpectedException();
    }
  }

  @override
  Future<PaginatedGenericType<PhotoEntity>> getList(
      int page, int countPerPage) async {
    try {
      int startIndex = (page - 1) * countPerPage;
      int totalPages = (await getTotalDocuments() / countPerPage).ceil();
      int remainingPages = totalPages - page;

      List<PhotoEntity> photos = [];

      if (startIndex >= await getTotalDocuments()) {
        return PaginatedGenericType(items: photos, countPage: remainingPages);
      }

      var photosCollection = firestore.collection("photos");

      QuerySnapshot<Map<String, dynamic>> query = await photosCollection
          .orderBy("uploadAt")
          .limit(countPerPage)
          .startAtDocument(
            await getDocumentSnapshot(photosCollection, startIndex),
          )
          .get();

      for (var doc in query.docs) {
        var data = doc.data();

        if (data["userId"] != null) {
          DocumentSnapshot<Map<String, dynamic>> userDoc =
              await firestore.collection("users").doc(data["userId"]).get();

          if (userDoc.data() != null) {
            try {
              photos.add(PhotoEntity.fromMap({
                "user": {"uid": userDoc.id, ...userDoc.data()!},
                "id": doc.id,
                ...data
              }));
            } catch (e) {
              if (kDebugMode) {
                print(e);
              }
            }
          }
        }
      }

      return PaginatedGenericType(items: photos, countPage: remainingPages);
    } on AppException catch (_) {
      rethrow;
    } catch (e) {
      throw UnexpectedException();
    }
  }

  @override
  Future<void> updateOne(
      String id, UpdateOneDatasourceInput updateFields) async {
    try {
      await firestore.collection("photos").doc(id).update(updateFields.toMap());
    } on AppException catch (_) {
      rethrow;
    } catch (e) {
      throw UnexpectedException();
    }
  }

  Future<int> getTotalDocuments() async {
    var query = await firestore.collection("photos").get();
    return query.size;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocumentSnapshot(
      CollectionReference<Map<String, dynamic>> collectionRef,
      int index) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await collectionRef.orderBy("uploadAt").limit(index + 1).get();
    return querySnapshot.docs.last;
  }
}
