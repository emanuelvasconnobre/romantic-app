import 'package:ayane/data/datasource/protocols/entities/photo_entity.dart';

class LocalPhoto {
  final PhotoEntity photo;
  final String? fileInternalPath;

  LocalPhoto(this.photo, {this.fileInternalPath});

  // TODO: get the fileInternalPath and transform to a stream file to show in the gallery and not consume the bucket service.
  getStreamFile() {}
}
