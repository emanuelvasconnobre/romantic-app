import 'package:flutter/foundation.dart';
import 'package:ayane/data/datasource/protocols/entities/photo_entity.dart';
import 'package:ayane/data/datasource/protocols/photo_datasource/photo_datasource.dart';
import 'package:ayane/data/datasource/protocols/photo_datasource/protocols/create_fields.dart';
import 'package:ayane/data/datasource/protocols/photo_datasource/protocols/update_fields.dart';
import 'package:ayane/utils/get_random_filename.dart';
import 'package:ayane/utils/paginated_generic_type.dart';

class DummyPhotoDatasource implements PhotoDatasource {
  @override
  Future<PhotoEntity> createOne(CreateOneDatasourceInput input) async {
    await Future.delayed(const Duration(seconds: 2));

    String id = getRandomFileName();
    PhotoEntity dummy = PhotoEntity.getDummy();
    dummy.id = id;

    return dummy;
  }

  @override
  Future<void> deleteOne(String id) async {
    await Future.delayed(const Duration(seconds: 2));

    if (kDebugMode) {
      print("Deletado com sucesso!");
    }
  }

  @override
  Future<PhotoEntity> getById(String id) async {
    PhotoEntity dummy = PhotoEntity.getDummy();
    dummy.id = id;

    return dummy;
  }

  @override
  Future<PaginatedGenericType<PhotoEntity>> getList(
      int page, int countPerPage) async {
    PhotoEntity dummy = PhotoEntity.getDummy();
    dummy.id = "$page";

    return PaginatedGenericType(items: [dummy], countPage: 4);
  }

  @override
  Future<void> updateOne(
      String id, UpdateOneDatasourceInput updateFields) async {
    await Future.delayed(const Duration(seconds: 2));

    if (kDebugMode) {
      print("Atualizado com sucesso!");
    }
  }
}
