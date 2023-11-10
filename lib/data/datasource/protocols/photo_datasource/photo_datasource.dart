import 'package:projects/data/datasource/protocols/entities/photo_entity.dart';
import 'package:projects/data/datasource/protocols/photo_datasource/protocols/create_fields.dart';
import 'package:projects/data/datasource/protocols/photo_datasource/protocols/update_fields.dart';
import 'package:projects/utils/paginated_generic_type.dart';

abstract class PhotoDatasource {
  Future<PaginatedGenericType<PhotoEntity>> getList(
      int page, int countPerPage) async {
    return PaginatedGenericType<PhotoEntity>(items: [], countPage: 5);
  }

  Future<PhotoEntity?> getById(String id) async {
    return PhotoEntity.getDummy();
  }

  Future<PhotoEntity> createOne(CreateOneDatasourceInput input) async {
    return PhotoEntity.getDummy();
  }

  Future<void> deleteOne(String id);

  Future<void> updateOne(String id, UpdateOneDatasourceInput updateFields);
}
