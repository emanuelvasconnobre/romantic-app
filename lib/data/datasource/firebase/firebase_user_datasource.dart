import 'package:romanticapp/data/datasource/protocols/entities/user_entity.dart';
import 'package:romanticapp/data/datasource/protocols/user_datasource/protocols/update_fields.dart';
import 'package:romanticapp/data/datasource/protocols/user_datasource/user_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../../utils/exceptions/intance_exception.dart';
import '../../../utils/exceptions/protocols/app_exception.dart';
import '../../../utils/exceptions/unexpected_exception.dart';

class FirebaseUserDatasource implements UserDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference<Map<String, dynamic>> userCollection;

  FirebaseUserDatasource() {
    userCollection = firestore.collection("users");
  }

  @override
  Future<UserEntity?> getById(String id) async {
    try {
      var entity = await userCollection.doc(id).get();
      Map<String, dynamic>? data = entity.data();

      if (data == null) {
        return null;
      }

      return UserEntity.fromMap({"uid": entity.id, ...data});
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
  Future<void> updateOne(
      String id, UpdateOneUserDatasourceInput updateFields) async {
    try {
      await userCollection.doc(id).update(updateFields.toMap());
    } on AppException catch (_) {
      rethrow;
    } catch (e) {
      throw UnexpectedException();
    }
  }
}
