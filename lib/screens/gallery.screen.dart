import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/bloc/gallery_bloc.dart';
import 'package:projects/screens/view-photo.screen.dart';

class GalleryScreen extends StatelessWidget {
  GalleryScreen({super.key});

  final ScrollController _scrollController = ScrollController();

  void _showDescription(BuildContext context, int index) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext builderContext) {
        return ViewPhotoScreen(index, context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<GalleryBloc>(context);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        bloc.addPage();
      }
    });

    return GalleryBlocBuilder(
        context: context,
        builder: (context, state) {
          return GridView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 8.0, mainAxisSpacing: 8.0),
            itemCount: state.photos.length,
            itemBuilder: (BuildContext buildContext, int index) {
              return InkWell(
                onTap: () {
                  _showDescription(context, index);
                },
                child: GridTile(
                  child: Image.network(
                    state.photos[index].photo.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        });
  }
}
