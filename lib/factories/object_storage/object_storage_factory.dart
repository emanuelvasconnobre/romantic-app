import 'package:romanticapp/data/object_storage/dummy/dummy_object_storage.dart';
import 'package:romanticapp/data/object_storage/firebase/firebase_object_storage.dart';

import '../../data/object_storage/protocols/object_storage.dart';

class ObjectStorageFactory {
  static ObjectStorage? objectStorage;

  static ObjectStorage getInstance() {
    return ObjectStorageFactory.getInstanceFromFirebase();
  }

  static ObjectStorage getInstanceFromFirebase() {
    ObjectStorage instance = FirebaseObjectStorage();

    ObjectStorageFactory.objectStorage = instance;

    return instance;
  }

  static ObjectStorage getInstanceFromDummy() {
    ObjectStorage instance = DummyObjectStorage();

    ObjectStorageFactory.objectStorage = instance;

    return instance;
  }
}
