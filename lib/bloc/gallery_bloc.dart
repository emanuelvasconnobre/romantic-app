import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:romanticapp/data/datasource/protocols/entities/photo_entity.dart';
import 'package:romanticapp/data/service/photo/photo_service.dart';
import 'package:romanticapp/data/service/photo/protocols/create_one_service_input.dart';
import 'package:romanticapp/factories/services/photo_service_factory.dart';
import 'package:romanticapp/utils/result_helper/result.dart';

GalleryBloc getGalleryBloc(BuildContext context) {
  return BlocProvider.of(context);
}

class GalleryBlocState {
  final List<PhotoEntity> photos;
  final int page;
  final int countPerPage = 2;
  final int countPage;

  GalleryBlocState(
      {required this.photos, required this.page, required this.countPage});
}

class GalleryBloc extends Cubit<GalleryBlocState> {
  final PhotoService _photoService = PhotoServiceFactory.getInstance();

  GalleryBloc() : super(GalleryBlocState(photos: [], page: 1, countPage: 2)) {
    initializer();
  }

  void initializer() async {
    var result = await _photoService.getList(page: 1, countPerPage: 2);

    if (result is Success) {
      emit(GalleryBlocState(
          photos: result.data!.items,
          page: 1,
          countPage: result.data!.countPage));
    }
  }

  addPage() async {
    int page = state.page + 1;

    var result = await _photoService.getList(
        page: page, countPerPage: state.countPerPage);

    if (result is Success) {
      emit(GalleryBlocState(
          page: page,
          countPage: result.data!.countPage,
          photos: [...state.photos, ...result.data!.items]));
    }
  }

  addOnePhoto(CreateOneServiceInput input) async {
    var result = await _photoService.createOne(input);

    if (result is Success) {
      emit(GalleryBlocState(
          photos: [...state.photos, result.data!],
          countPage: state.countPage,
          page: state.page));
    }
  }

  removeOnePhoto(String id) async {
    final targetList = state.photos;

    var result = await _photoService.deleteOne(id);

    if (result is Success) {
      targetList.removeWhere((element) => element.id == id);

      emit(GalleryBlocState(
        photos: targetList,
        page: state.page,
        countPage: state.countPage,
      ));
    }
  }
}

class GalleryBlocBuilder extends BlocBuilder<GalleryBloc, GalleryBlocState> {
  GalleryBlocBuilder({
    Key? key,
    required BuildContext context,
    BlocBuilderCondition<GalleryBlocState>? buildWhen,
    required Widget Function(BuildContext, GalleryBlocState) builder,
  }) : super(
          key: key,
          bloc: BlocProvider.of<GalleryBloc>(context),
          builder: builder,
          buildWhen: buildWhen,
        );
}
