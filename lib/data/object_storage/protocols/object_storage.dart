import 'dart:io';

class FileStoraged {
  final String imageUrl;
  final String fileName;

  FileStoraged({required this.imageUrl, required this.fileName});
}

abstract class ObjectStorage {
  Future<FileStoraged> uploadOne(File file, {String? fileName}) async {
    return FileStoraged(imageUrl: "imageUrl", fileName: "fileName");
  }

  Future<void> deleteOne(String fileName);
}