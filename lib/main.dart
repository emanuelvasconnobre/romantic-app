import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:romanticapp/bloc/auth_bloc.dart';
import 'package:romanticapp/bloc/gallery_bloc.dart';
import 'package:romanticapp/pages/gallery_page.dart';
import 'package:romanticapp/routes/is_authenticated.route.dart';
import 'package:romanticapp/routes/is_not_authenticated.route.dart';
import 'package:romanticapp/screens/home.screen.dart';
import 'package:romanticapp/screens/login.screen.dart';

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
