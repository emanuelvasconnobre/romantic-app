import 'package:flutter/material.dart';
import 'package:projects/data/repository/protocols/entities/Photo.dart';
import 'package:projects/screens/view-photo.screen.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final List<PhotoEntity> photos = [
    PhotoEntity(
        'https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Senna_27.jpg',
        'Descrição da imagem 1',
        'originalname.jpg',
        'kefoawie23412kio.jpg',
        DateTime(2023),
        25.0,
        'oakf213uj4oi1un3251'
    ),
    PhotoEntity(
        'https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Senna_27.jpg',
        'Descrição da imagem 2',
        'originalname.jpg',
        'kefoawie23412kio.jpg',
        DateTime(2023),
        25.0,
        'oakf213uj4oi1un3251'
    ),
  ];

  void _showDescription(BuildContext context, int index) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return ViewPhotoScreen(photos, index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Galeria'),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 8.0, mainAxisSpacing: 8.0),
          itemCount: photos.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                _showDescription(context, index);
              },
              child: GridTile(
                child: Image.network(
                  photos[index].imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ));
  }
}
