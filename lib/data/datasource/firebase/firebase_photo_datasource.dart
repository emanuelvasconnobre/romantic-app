import 'package:flutter/foundation.dart';
import 'package:projects/data/datasource/protocols/entities/photo_entity.dart';
import 'package:projects/data/datasource/protocols/photo_datasource/photo_datasource.dart';
import 'package:projects/data/datasource/protocols/photo_datasource/protocols/create_fields.dart';
import 'package:projects/data/datasource/protocols/photo_datasource/protocols/update_fields.dart';
import 'package:projects/utils/get_random_filename.dart';
import 'package:projects/utils/paginated_generic_type.dart';

class FirebasePhotoDatasource implements PhotoDatasource {
  @override
  Future<PhotoEntity> createOne(CreateOneDatasourceInput input) async {
    await Future.delayed(const Duration(seconds: 2));

    String id = getRandomFileName();

    return PhotoEntity(
        id,
        input.imageUrl,
        input.description,
        input.originalName,
        input.fileName,
        input.uploadAt,
        input.size,
        input.userId);
  }

  @override
  Future<void> deleteOne(String id) async {
    if (kDebugMode) {
      print("Deletado com sucesso!");
    }
  }

  @override
  Future<PhotoEntity> getById(String id) async {
    await Future.delayed(const Duration(seconds: 2));

    return PhotoEntity(
        id,
        "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Senna_27.jpg",
        "description $id",
        "originalName",
        "fileName",
        DateTime.now(),
        22.0,
        "userId");
  }

  @override
  Future<PaginatedGenericType<PhotoEntity>> getList(
      int page, int countPerPage) async {
    return PaginatedGenericType(items: [
      PhotoEntity(
          "$page",
          "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Senna_27.jpg",
          "description $page",
          "originalName",
          "fileName",
          DateTime.now(),
          22.0,
          "userId")
    ], countPage: 4);
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
