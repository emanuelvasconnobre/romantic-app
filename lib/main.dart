import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/bloc/auth_bloc.dart';
import 'package:projects/bloc/gallery_bloc.dart';
import 'package:projects/pages/gallery_page.dart';
import 'package:projects/routes/is_authenticated.route.dart';
import 'package:projects/routes/is_not_authenticated.route.dart';
import 'package:projects/screens/home.screen.dart';
import 'package:projects/screens/login.screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    BlocProvider(
      create: (context) => AuthBloc(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/login',
        navigatorKey: appNavigatorKey,
        routes: {
          '/': (context) => const IsNotAuthenticatedRoute(HomeScreen()),
          '/login': (context) => IsNotAuthenticatedRoute(
              LoginScreen(navigatorKey: appNavigatorKey)),
          '/gallery': (context) => IsAuthenticatedRoute(BlocProvider(
              create: (context) => GalleryBloc(), child: GalleryPage(navigatorKey: appNavigatorKey))),
        });
  }
}
