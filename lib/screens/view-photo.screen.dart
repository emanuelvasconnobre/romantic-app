import 'package:flutter/material.dart';
import 'package:projects/data/repository/protocols/entities/Photo.dart';

class ViewPhotoScreen extends StatefulWidget {
  final List<PhotoEntity> listOfPhotos;

  final int initialIndex;

  final PhotoEntity target;

  final PageController _controller;

  ViewPhotoScreen(this.listOfPhotos, this.initialIndex, {super.key})
      : _controller = PageController(
          initialPage: initialIndex,
        ),
        target = listOfPhotos[initialIndex];

  @override
  State<ViewPhotoScreen> createState() => _ViewPhotoScreenState();
}

class _ViewPhotoScreenState extends State<ViewPhotoScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
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
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(width: 40), // Ajuste de espaço
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: PageView.builder(
                    controller: widget._controller,
                    itemCount: widget.listOfPhotos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Image.network(
                        widget.listOfPhotos[index].imageUrl,
                        fit: BoxFit.contain,
                      );
                    }),
              ),
            ),
            const SizedBox(height: 20), // Ajuste de espaço
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: null,
                      icon: Icon(Icons.info),
                    ),
                    Text(
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
                      onPressed: null,
                      icon: Icon(Icons.delete),
                    ),
                    Text(
                      'Deletar',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20), // Ajuste de espaço
          ],
        ));
  }
}
