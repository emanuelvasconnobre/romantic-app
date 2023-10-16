import 'package:flutter/material.dart';
import 'package:projects/provider/auth.provider.dart';
import 'package:projects/routes/is_authenticated.route.dart';
import 'package:projects/routes/is_not_authenticated.route.dart';
import 'package:projects/screens/gallery.screen.dart';
import 'package:projects/screens/home.screen.dart';
import 'package:projects/screens/login.screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AuthProvider(),
    child: const MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/gallery',
      routes: {
        '/': (context) => const IsNotAuthenticatedRoute(HomeScreen()),
        '/login': (context) => const IsNotAuthenticatedRoute(LoginScreen()),
        '/gallery': (context) => const IsAuthenticatedRoute(GalleryScreen()),
      }
    );
  }
}
