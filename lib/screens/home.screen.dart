import 'package:flutter/material.dart';
import 'package:romanticapp/widgets/UI/app_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: AppButton(
          'Fazer login',
          routeName: "/login",
        ),
      ),
    );
  }
}