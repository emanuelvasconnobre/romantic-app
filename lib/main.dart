import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/bloc/auth_bloc.dart';
import 'package:projects/bloc/gallery_bloc.dart';
import 'package:projects/pages/gallery_page.dart';
import 'package:projects/routes/is_authenticated.route.dart';
import 'package:projects/routes/is_not_authenticated.route.dart';
import 'package:projects/screens/home.screen.dart';
import 'package:projects/screens/login.screen.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => AuthBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/login', routes: {
      '/': (context) => const IsNotAuthenticatedRoute(HomeScreen()),
      '/login': (context) => const IsNotAuthenticatedRoute(LoginScreen()),
      '/gallery': (context) => IsAuthenticatedRoute(BlocProvider(
          create: (context) => GalleryBloc(), child: const GalleryPage())),
    });
  }
}
