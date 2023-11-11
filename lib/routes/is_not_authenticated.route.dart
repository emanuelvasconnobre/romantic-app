import 'package:flutter/material.dart';
import 'package:ayane/provider/utils/is_authenticed.dart';

class IsNotAuthenticatedRoute extends StatelessWidget {
  final Widget page;

  const IsNotAuthenticatedRoute(this.page, {super.key});

  @override
  Widget build(BuildContext context) {
    return !isAuthenticated(context) ? page : _fallBack(context);
  }

  Widget _fallBack(BuildContext context) {
    Future.microtask(() {
      Navigator.pushReplacementNamed(context, '/gallery');
    });
    return Container();
  }
}
