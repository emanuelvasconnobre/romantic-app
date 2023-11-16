import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:romanticapp/bloc/gallery_bloc.dart';
import 'package:romanticapp/data/datasource/protocols/entities/photo_entity.dart';
import 'package:romanticapp/widgets/gallery/view_photo_info.dart';

class ViewPhotoScreen extends StatelessWidget {
  final int initialIndex;
  final BuildContext parentContext;
  final PageController _controller;
  final GlobalKey<NavigatorState> navigatorKey;

  ViewPhotoScreen(
      {required this.initialIndex,
      required this.parentContext,
      super.key,
      required this.navigatorKey})
      : _controller = PageController(
          initialPage: initialIndex,
        );

  @override
  Widget build(BuildContext context) {
    final galleryBloc = BlocProvider.of<GalleryBloc>(parentContext);

    if (galleryBloc.state.photos.length == 1) {
      galleryBloc.addPage();
    }

    return Container(
        height: MediaQuery.of(parentContext).size.height,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(parentContext).pop();
                    },
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: GalleryBlocBuilder(
                  context: parentContext,
                  builder: (context, state) {
                    return PageView.builder(
                        controller: _controller,
                        itemCount: state.photos.length,
                        onPageChanged: (int currentPage) {
                          if (state.photos.length - currentPage == 1) {
                            galleryBloc.addPage();
                          }
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(
                            state.photos[index].imageUrl,
                            fit: BoxFit.contain,
                          );
                        });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        int currentIndex = _controller.page!.round();

                        PhotoEntity currentPhoto =
                            galleryBloc.state.photos[currentIndex];

                        _showDetails(context, currentPhoto);
                      },
                      icon: const Icon(Icons.info),
                    ),
                    const Text(
                      'Ver detalhes',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () async {
                        await _showConfirmationDialog(
                          context,
                          () async {
                            int currentIndex = _controller.page!.round();

                            String id =
                                galleryBloc.state.photos[currentIndex].id;
                            await galleryBloc.removeOnePhoto(id);
                          },
                        );
                      },
                      icon: const Icon(Icons.delete),
                    ),
                    const Text(
                      'Deletar',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ));
  }

  void _showDetails(BuildContext context, PhotoEntity photoEntity) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ViewPhotoInfo(photoEntity: photoEntity);
      },
    );
  }

  Future<void> _showConfirmationDialog(
    BuildContext context,
    Future<void> Function() onPressed,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmação de Exclusão'),
          content: const Text('Tem certeza de que deseja excluir esta imagem?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fechar o modal
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                await onPressed();
                navigatorKey.currentState?.pop();
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }
}
