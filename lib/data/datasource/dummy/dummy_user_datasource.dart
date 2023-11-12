import 'package:romanticapp/data/datasource/protocols/entities/user_entity.dart';
import 'package:romanticapp/data/datasource/protocols/user_datasource/protocols/update_fields.dart';
import 'package:romanticapp/data/datasource/protocols/user_datasource/user_datasource.dart';
import 'package:flutter/foundation.dart';

class DummyUserDatasource implements UserDatasource {
  @override
  Future<UserEntity?> getById(String id) async {
    UserEntity dummy = UserEntity.getDummy();
    dummy.uid = id;

    return dummy;
  }

  @override
  Future<void> updateOne(
      String id, UpdateOneUserDatasourceInput updateFields) async {
    await Future.delayed(const Duration(seconds: 2));

    if (kDebugMode) {
      print("Atualizado com sucesso!");
    }
  }
}
