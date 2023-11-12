import 'package:ayane/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ayane/screens/gallery.screen.dart';
import 'package:ayane/screens/upload_image_screen.dart';

import '../bloc/auth_bloc.dart';

class GalleryPage extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const GalleryPage({required this.navigatorKey, super.key});

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(Icons.home), // Customize the icon as needed
              onPressed: () {
                navigatorKey.currentState?.pushNamed('/');
              },
            ),
            title: const Text('Romantic App'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await authBloc.logOut();

                  if (!authBloc.isLoggedIn) {
                    navigatorKey.currentState?.pushNamed('/');
                  }
                },
              ),
            ],
          ),
          body: TabBarView(
            children: [
              GalleryScreen(navigatorKey: navigatorKey, parentContext: context),
              UploadImageScreen(
                  navigatorKey: navigatorKey, parentContext: context),
              ProfileScreen(
                  navigatorKey: navigatorKey, parentContext: context),
            ],
          ),
          bottomNavigationBar: Container(
              color: Colors.blue,
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
