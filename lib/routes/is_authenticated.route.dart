import 'package:flutter/material.dart';
import 'package:projects/provider/utils/is_authenticed.dart';
import 'package:projects/screens/home.screen.dart';

class IsAuthenticatedRoute extends StatelessWidget {
  final Widget page;

  const IsAuthenticatedRoute(this.page, {super.key});

  @override
  Widget build(BuildContext context) {
    return isAuthenticated(context) ? page : _fallBack(context);
  }

  Widget _fallBack(BuildContext context) {
    Future.microtask(() {
      Navigator.pushReplacementNamed(context, '/login');
    });
    return Container();
  }
}
