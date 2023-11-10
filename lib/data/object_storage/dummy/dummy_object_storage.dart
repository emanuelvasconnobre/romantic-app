import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:projects/data/object_storage/protocols/object_storage.dart';

class DummyObjectStorage implements ObjectStorage {
  @override
  Future<void> deleteOne(String fileName) async {
    await Future.delayed(const Duration(seconds: 2));

    if (kDebugMode) {
      print("Deletado");
    }
  }

  @override
  Future<FileStoraged> uploadOne(File file, {String? fileName}) async {
    await Future.delayed(const Duration(seconds: 2));

    return FileStoraged(
        imageUrl: "imageUrl",
        fileName: "randomFileName.jpg",
        originalName: "original",
        size: 20.0);
  }
}
