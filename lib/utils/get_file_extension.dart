import 'dart:io';

String getFileExtension(File file) {
  String filePath = file.path;

  int lastIndex = filePath.lastIndexOf('.');

  if (lastIndex != -1 && lastIndex < filePath.length - 1) {
    String extension = filePath.substring(lastIndex + 1);
    return extension;
  } else {
    return '';
  }
}