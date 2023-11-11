import 'package:ayane/data/datasource/dummy/dummy_photo_datasource.dart';
import 'package:ayane/data/datasource/firebase/firebase_photo_datasource.dart';
import 'package:ayane/factories/object_storage/object_storage_factory.dart';

import '../../data/service/photo/photo_service.dart';

class PhotoServiceFactory {
  static PhotoService? authServiceInstance;

  static PhotoService getInstance() {
    return PhotoServiceFactory.getInstanceFromFirebase();
  }

  static PhotoService getInstanceFromFirebase() {
    PhotoService instance = PhotoService(
        objectStorage: ObjectStorageFactory.getInstanceFromFirebase(),
        photoDatasource: FirebasePhotoDatasource());

    PhotoServiceFactory.authServiceInstance = instance;

    return instance;
  }

  static PhotoService getInstanceFromDummy() {
    PhotoService instance = PhotoService(
        objectStorage: ObjectStorageFactory.getInstanceFromDummy(),
        photoDatasource: DummyPhotoDatasource());

    PhotoServiceFactory.authServiceInstance = instance;

    return instance;
  }
}
