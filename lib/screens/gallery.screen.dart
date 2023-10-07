import 'package:flutter/material.dart';

class Photo {
  String imageUrl;
  String description;

  Photo(this.imageUrl, this.description);
}

class GalleryScreen extends StatelessWidget {
  final List<Photo> photos = [
    Photo(
        'https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Senna_27.jpg',
        'Descrição da imagem 1'),
    Photo(
        'https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Senna_27.jpg',
        'Descrição da imagem 2'),
    Photo(
        'https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Senna_27.jpg',
        'Descrição da imagem 3'),
    Photo(
        'https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Senna_27.jpg',
        'Descrição da imagem 4'),
    Photo(
        'https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Senna_27.jpg',
        'Descrição da imagem 5'),
  ];

  GalleryScreen({super.key});

  void _showDescription(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Descrição'),
          content: Text(photos[index].description),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
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
