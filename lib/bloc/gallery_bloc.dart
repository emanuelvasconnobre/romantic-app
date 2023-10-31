import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/bloc/protocols/local_photo.dart';
import 'package:projects/data/datasource/protocols/entities/photo_entity.dart';

class GalleryBlocState {
  final List<LocalPhoto> photos;
  final int page;
  final int countPerPage = 8;

  GalleryBlocState(this.photos, this.page);
}

class AddOneEvent {
  final LocalPhoto newEntity;

  AddOneEvent(this.newEntity);
}

class RemoveOneEvent {
  final String id;

  RemoveOneEvent(this.id);
}

// TODO: change for async methods.
class GalleryBloc extends Cubit<GalleryBlocState> {
  GalleryBloc() : super(GalleryBlocState([], 1)) {
    initializer();
  }

  void initializer() {
    final id = "${state.photos.length + 1}";

    emit(GalleryBlocState([
      LocalPhoto(
          int.parse(id),
          PhotoEntity(
              id,
              "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Senna_27.jpg",
              "description $id",
              "originalName",
              "fileName",
              DateTime.now(),
              22.0,
              "userId"))
    ], state.page));
  }

  void addPage() {
    final page = state.page + 1;
    final id = "${state.photos.length + 1}";

    emit(GalleryBlocState([
      ...state.photos,
      ...[
        LocalPhoto(
            int.parse(id),
            PhotoEntity(
                id,
                "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Senna_27.jpg",
                "description $id",
                "originalName",
                "fileName",
                DateTime.now(),
                22.0,
                "userId")),
      ]
    ], page));
  }

  // TODO: define the input data.
  void addOnePhoto() {
    var id = "${state.photos.length + 1}";

    final dummyPhoto = LocalPhoto(
        int.parse(id),
        PhotoEntity(
            id,
            "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Senna_27.jpg",
            "description $id",
            "originalName",
            "fileName",
            DateTime.now(),
            22.0,
            "userId"));

    List<LocalPhoto> updatedList = List.from(state.photos)..add(dummyPhoto);

    emit(GalleryBlocState(updatedList, state.page + 1));
  }

  void removeOnePhoto(String id) {
    final targetList = state.photos;

    targetList.removeWhere((element) => element.photo.id == id);

    emit(GalleryBlocState(targetList, state.page));
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
