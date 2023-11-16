import 'package:romanticapp/data/datasource/protocols/entities/photo_entity.dart';
import 'package:romanticapp/data/datasource/protocols/photo_datasource/photo_datasource.dart';
import 'package:romanticapp/data/datasource/protocols/photo_datasource/protocols/create_fields.dart';
import 'package:romanticapp/data/object_storage/protocols/object_storage.dart';
import 'package:romanticapp/data/service/photo/protocols/create_one_service_input.dart';
import 'package:romanticapp/utils/exceptions/protocols/app_exception.dart';
import 'package:romanticapp/utils/exceptions/unexpected_exception.dart';
import 'package:romanticapp/utils/paginated_generic_type.dart';
import 'package:romanticapp/utils/result_helper/result.dart';

class PhotoService {
  final PhotoDatasource photoDatasource;
  final ObjectStorage objectStorage;

  PhotoService({required this.photoDatasource, required this.objectStorage});

  Future<Result<PaginatedGenericType<PhotoEntity>>> getList(
      {int? page, int? countPerPage}) async {
    try {
      final items = await photoDatasource.getList(page ?? 1, countPerPage ?? 4);
      return Success(data: items);
    } on AppException catch (e) {
      return Failure(e);
    }
  }

  Future<Result<PhotoEntity>> createOne(CreateOneServiceInput input) async {
    try {
      final objectCreated = await objectStorage.uploadOne(input.image);

      final createInput = CreateOneDatasourceInput(
          imageUrl: objectCreated.imageUrl,
          description: input.description,
          originalName: objectCreated.originalName,
          fileName: objectCreated.fileName,
          uploadAt: objectCreated.uploadAt,
          size: objectCreated.size,
          userId: input.userId);

      final createdData = await photoDatasource.createOne(createInput);

      return Success(data: createdData);
    } on AppException catch (e) {
      return Failure(e);
    }
  }

  Future<Result> deleteOne(String id) async {
    try {
      var entity = await photoDatasource.getById(id);

      if (entity == null) {
        throw UnexpectedException();
      }

      await photoDatasource.deleteOne(id);
      await objectStorage.deleteOne(entity.fileName);

      return Success(data: null);
    } on AppException catch (e) {
      return Failure(e);
    }
  }
}
