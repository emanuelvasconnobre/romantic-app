import 'dart:io';

double getFileSize(File file) {
  int fileSizeInBytes = file.lengthSync();
  double fileSizeInMB =
      fileSizeInBytes / (1024 * 1024); // Convertendo bytes para megabytes

  return fileSizeInMB;
}
