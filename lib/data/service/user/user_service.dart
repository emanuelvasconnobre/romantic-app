import 'package:romanticapp/cache/map_cache/user_map_cache.dart';
import 'package:romanticapp/data/datasource/protocols/entities/user_entity.dart';
import 'package:romanticapp/data/datasource/protocols/user_datasource/protocols/update_fields.dart';
import 'package:romanticapp/data/object_storage/protocols/object_storage.dart';
import 'package:romanticapp/data/service/user/protocols/update_profile_service_input.dart';
import 'package:romanticapp/data/service/user/protocols/update_profile_service_output.dart';
import 'package:romanticapp/utils/exceptions/auth/user_data_missing_exception.dart';
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
        throw UserDataMissingException();
      }

      userCache.set(key: uid, value: data);

      return Success(data: data);
    } on AppException catch (e) {
      return Failure(e);
    }
  }

  Future<Result<UpdateProfileUserServiceOutput>> updateProfile(
      String uid, UpdateProfileUserServiceInput input) async {
    try {
      final datasourceInput = UpdateOneUserDatasourceInput(
          name: null, bio: null, profilePictureUrl: null);
      if (input.profilePicture != null) {
        datasourceInput.profilePictureUrl =
            (await objectStorage.uploadOne(input.profilePicture!)).imageUrl;
      }
      if (input.name != null) datasourceInput.name = input.name!;
      if (input.bio != null) datasourceInput.bio = input.bio!;

      await userDatasource.updateOne(uid, datasourceInput);

      return Success(
          data: UpdateProfileUserServiceOutput(
        profilePictureUrl: datasourceInput.profilePictureUrl,
        name: input.name,
        bio: input.bio,
      ));
    } on AppException catch (e) {
      return Failure(e);
    }
  }
}
