import 'package:romanticapp/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:romanticapp/screens/gallery.screen.dart';
import 'package:romanticapp/screens/upload_image_screen.dart';
import 'package:romanticapp/utils/app_color.dart';

class GalleryPage extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const GalleryPage({required this.navigatorKey, super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Romantic App'),
            backgroundColor: AppColor.primaryBgColor,
          ),
          body: TabBarView(
            children: [
              GalleryScreen(navigatorKey: navigatorKey, parentContext: context),
              UploadImageScreen(
                  navigatorKey: navigatorKey, parentContext: context),
              ProfileScreen(navigatorKey: navigatorKey, parentContext: context),
            ],
          ),
          bottomNavigationBar: Container(
              color: AppColor.primaryBgColor,
              child: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.image), text: 'Galeria'),
                  Tab(icon: Icon(Icons.add_a_photo), text: 'Adicionar'),
                  Tab(icon: Icon(Icons.person), text: 'Perfil'),
                ],
              )),
        ));
  }
}
