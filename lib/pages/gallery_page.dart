import 'package:flutter/material.dart';
import 'package:projects/screens/gallery.screen.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Romantic App'),
          ),
          body: TabBarView(
            children: [
              GalleryScreen(),
              const Center(
                child: Text('Image Tab Content'),
              ),
            ],
          ),
          bottomNavigationBar: Container(
              color: Colors.blue,
              child: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.image), text: 'Galeria'),
                  Tab(icon: Icon(Icons.add_a_photo), text: 'Adicionar'),
                ],
              )),
        ));
  }
}
