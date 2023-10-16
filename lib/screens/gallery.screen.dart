import 'package:flutter/material.dart';

class Photo {
  String imageUrl;
  String description;

  Photo(this.imageUrl, this.description);
}

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final List<Photo> photos = [
    Photo(
        'https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Senna_27.jpg',
        'Descrição da imagem 1'),
    Photo(
        'https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Senna_27.jpg',
        'Descrição da imagem 2'),
  ];

  void _showDescription(BuildContext context, int index) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
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
                  child: Image.network(
                    photos[index].imageUrl,
                    fit: BoxFit.contain,
                  ),
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
          ),
        );
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
