import 'package:projects/data/datasource/protocols/entities/photo_entity.dart';
import 'package:projects/data/datasource/protocols/photo_datasource/photo_datasource.dart';
import 'package:projects/data/datasource/protocols/photo_datasource/protocols/create_fields.dart';
import 'package:projects/data/object_storage/protocols/object_storage.dart';
import 'package:projects/data/service/photo/protocols/create_one_service_input.dart';
import 'package:projects/utils/paginated_generic_type.dart';
import 'package:projects/utils/result_helper/result.dart';

class PhotoService {
  final PhotoDatasource photoDatasource;
  final ObjectStorage objectStorage;

  PhotoService({required this.photoDatasource, required this.objectStorage});

  Future<Result<PaginatedGenericType<PhotoEntity>>> getList(
      {int page = 1, int countPerPage = 100}) async {
    final items = await photoDatasource.getList(page, countPerPage);
    return Success(data: items);
  }

  Future<Result<PhotoEntity>> createOne(CreateOneServiceInput input) async {
    final objectCreated = await objectStorage.uploadOne(input.image);

    final createInput = CreateOneDatasourceInput(
      imageUrl: objectCreated.imageUrl,
      description: input.description,
      originalName: input.originalName,
      fileName: objectCreated.fileName,
      uploadAt: input.uploadAt,
      size: input.size,
    );

    final createdData = await photoDatasource.createOne(createInput);

    return Success(data: createdData);
  }

  Future<Result> deleteOne(int id) async {
    return Success(data: null);
  }
}
