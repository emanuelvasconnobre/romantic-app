import 'package:flutter/material.dart';
import 'package:romanticapp/bloc/gallery_bloc.dart';
import 'package:romanticapp/screens/view-photo.screen.dart';
import 'package:romanticapp/widgets/gallery/gallery_image.dart';

class GalleryScreen extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  final BuildContext parentContext;

  const GalleryScreen(
      {required this.navigatorKey, required this.parentContext, super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final ScrollController _scrollController = ScrollController();

  void _showPhotoDetails(BuildContext context, int index) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext builderContext) {
        return ViewPhotoScreen(
          initialIndex: index,
          parentContext: widget.parentContext,
          navigatorKey: widget.navigatorKey,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = getGalleryBloc(widget.parentContext);

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
                  _showPhotoDetails(context, index);
                },
                child: GridTile(
                  child: GalleryImage(
                    photo: state.photos[index],
                  ),
                ),
              );
            },
          );
        });
  }
}
