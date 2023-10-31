import 'package:projects/data/datasource/protocols/entities/photo_entity.dart';
import 'package:projects/data/datasource/protocols/photo_datasource/protocols/update_fields.dart';

abstract class PhotoDatasource {
  List<PhotoEntity> getList(int page, int countPerPage) {
    return [];
  }

  PhotoEntity getById(String id) {
    return PhotoEntity.getDumpInstance();
  }

  void deleteOne(String id);

  void updateOne(String id, UpdateFields updateFields);
}
