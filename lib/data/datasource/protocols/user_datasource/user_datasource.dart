import 'package:romanticapp/data/datasource/protocols/entities/user_entity.dart';
import 'package:romanticapp/data/datasource/protocols/user_datasource/protocols/update_fields.dart';

abstract class UserDatasource {
  Future<UserEntity?> getById(String id);

  Future<void> updateOne(String id, UpdateOneUserDatasourceInput updateFields);
}
