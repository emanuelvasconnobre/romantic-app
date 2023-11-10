import 'dart:io';

class FileStoraged {
  final String imageUrl;
  final String fileName;
  final String originalName;
  final double size;
  final DateTime uploadAt = DateTime.now();

  FileStoraged({required this.imageUrl, required this.fileName, required this.originalName, required this.size});
}

abstract class ObjectStorage {
  Future<FileStoraged> uploadOne(File file, {String? fileName});

  Future<void> deleteOne(String fileName);
}