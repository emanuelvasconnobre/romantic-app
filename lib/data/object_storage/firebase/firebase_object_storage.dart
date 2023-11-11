import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ayane/data/object_storage/protocols/object_storage.dart';
import 'package:ayane/utils/exceptions/unexpected_exception.dart';
import 'package:ayane/utils/get_file_size.dart';
import 'package:ayane/utils/get_random_filename.dart';

class FirebaseObjectStorage implements ObjectStorage {
  final storage = FirebaseStorage.instance;

  @override
  Future<void> deleteOne(String fileName) async {
    try {
      Reference appDocDirectory = getGalleryFolderRef();
      final fileToDelete = appDocDirectory.child(fileName);

      await fileToDelete.delete();
    } catch (e) {
      throw UnexpectedException();
    }
  }

  @override
  Future<FileStoraged> uploadOne(File file, {String? fileName}) async {
    try {
      String randomFileName =
          fileName ?? "${getRandomFileName()}.${file.path.split(".").last}";

      Reference folder = getGalleryFolderRef().child(randomFileName);

      UploadTask task = folder.putFile(file);

      TaskSnapshot snapshot = await task;

      String imageUrl = await snapshot.ref.getDownloadURL();

      return FileStoraged(
          imageUrl: imageUrl,
          fileName: randomFileName,
          originalName: file.path.split("/").last,
          size: getFileSize(file));
    } catch (e) {
      throw UnexpectedException();
    }
  }

  Reference getGalleryFolderRef() {
    return storage.ref("gallery_images");
  }
}
