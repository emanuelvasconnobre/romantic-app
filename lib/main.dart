import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ayane/bloc/auth_bloc.dart';
import 'package:ayane/bloc/gallery_bloc.dart';
import 'package:ayane/pages/gallery_page.dart';
import 'package:ayane/routes/is_authenticated.route.dart';
import 'package:ayane/routes/is_not_authenticated.route.dart';
import 'package:ayane/screens/home.screen.dart';
import 'package:ayane/screens/login.screen.dart';

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
