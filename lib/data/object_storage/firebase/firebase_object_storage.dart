import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:romanticapp/data/object_storage/protocols/object_storage.dart';
import 'package:romanticapp/utils/exceptions/unexpected_exception.dart';
import 'package:romanticapp/utils/get_file_extension.dart';
import 'package:romanticapp/utils/get_file_size.dart';
import 'package:romanticapp/utils/get_random_filename.dart';

class FirebaseObjectStorage implements ObjectStorage {
  final storage = FirebaseStorage.instance;

  @override
  Future<void> deleteOne(String fileName) async {
    try {
      Reference appDocDirectory = getFolderRef();
      final fileToDelete = appDocDirectory.child(fileName);

      await fileToDelete.delete();
    } catch (e) {
      throw UnexpectedException();
    }
  }

  @override
  Future<FileStoraged> uploadOne(File file, {String? fileName, String? path}) async {
    try {
      String extension = getFileExtension(file);
      String fileNameSelected =
          fileName ?? "${getRandomFileName()}.$extension";

      Reference folder = getFolderRef(path: path).child(fileNameSelected);

      UploadTask task = folder.putFile(file);

      TaskSnapshot snapshot = await task;

      String imageUrl = await snapshot.ref.getDownloadURL();

      return FileStoraged(
          imageUrl: imageUrl,
          fileName: fileNameSelected,
          originalName: file.path.split("/").last,
          size: getFileSize(file));
    } catch (e) {
      throw UnexpectedException();
    }
  }

  Reference getFolderRef({String? path}) {
    return storage.ref(path ?? "gallery_images");
  }
}
