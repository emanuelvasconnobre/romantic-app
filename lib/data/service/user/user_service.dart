import 'package:romanticapp/cache/map_cache/user_map_cache.dart';
import 'package:romanticapp/data/datasource/protocols/entities/user_entity.dart';
import 'package:romanticapp/data/datasource/protocols/user_datasource/protocols/update_fields.dart';
import 'package:romanticapp/data/object_storage/protocols/object_storage.dart';
import 'package:romanticapp/data/service/user/protocols/update_profile_service_input.dart';
import 'package:romanticapp/utils/exceptions/data_not_found.dart';
import 'package:romanticapp/utils/exceptions/protocols/app_exception.dart';
import 'package:romanticapp/utils/result_helper/result.dart';

import '../../datasource/protocols/user_datasource/user_datasource.dart';

class UserService {
  final UserDatasource userDatasource;
  final ObjectStorage objectStorage;
  final UserEntityMapCache userCache;

  UserService({required this.userDatasource, required this.objectStorage})
      : userCache = UserEntityMapCache();

  Future<Result<UserEntity>> getProfile(String uid) async {
    try {
      UserEntity? data;

      if (userCache.exists(uid)) {
        return Success(data: userCache.get(uid)!);
      }

      data = await userDatasource.getById(uid);

      if (data == null) {
        throw DataNotFoundException();
      }

      userCache.set(key: uid, value: data);

      return Success(data: data);
    } on AppException catch (e) {
      return Failure(e);
    }
  }

  Future<Result> updateProfile(
      String uid, UpdateProfileUserServiceInput input) async {
    try {
      final objectStoraged =
          await objectStorage.uploadOne(input.profilePicture);

      final datasourceInput = UpdateOneUserDatasourceInput(
        profilePictureUrl: objectStoraged.imageUrl,
        bio: input.bio,
        name: input.name,
      );

      await userDatasource.updateOne(uid, datasourceInput);

      return Success(data: null);
    } on AppException catch (e) {
      return Failure(e);
    }
  }
}
