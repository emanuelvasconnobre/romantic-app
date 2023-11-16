import '../../data/datasource/dummy/dummy_user_datasource.dart';
import '../../data/datasource/firebase/firebase_user_datasource.dart';
import '../../data/service/user/user_service.dart';
import '../object_storage/object_storage_factory.dart';

class UserServiceFactory {
  static UserService? authServiceInstance;

  static UserService getInstance() {
    return UserServiceFactory.getInstanceFromFirebase();
  }

  static UserService getInstanceFromFirebase() {
    UserService instance = UserService(
        objectStorage: ObjectStorageFactory.getInstanceFromFirebase(),
        userDatasource: FirebaseUserDatasource());

    UserServiceFactory.authServiceInstance = instance;

    return instance;
  }

  static UserService getInstanceFromDummy() {
    UserService instance = UserService(
        objectStorage: ObjectStorageFactory.getInstanceFromDummy(),
        userDatasource: DummyUserDatasource());

    UserServiceFactory.authServiceInstance = instance;

    return instance;
  }
}