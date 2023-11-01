import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/bloc/auth_bloc.dart';
import 'package:projects/validation/composite.validation.dart';
import 'package:projects/validation/form/email.validation.dart';
import 'package:projects/validation/form/is_not_empty.validation.dart';
import 'package:projects/validation/form/min_length.validation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? _validateEmail(String? value) {
    const fieldName = "email";

    var composite = CompositeValidation(
        [IsNotEmptyValidation(fieldName), EmailValidation()]);

    var validationResult = composite.validate(value);

    if (validationResult != null) {
      return validationResult;
    }

    return null;
  }

  String? _validatePassword(String? value) {
    const fieldName = "senha";
    var composite = CompositeValidation([
      IsNotEmptyValidation(fieldName),
      MinLengthValidation(fieldName, 8),
    ]);

    var validationResult = composite.validate(value);

    if (validationResult != null) {
      return validationResult;
    }

    return null;
  }

  void _onSubmitHandler(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;

      final bloc = BlocProvider.of<AuthBloc>(context);

      bloc.logIn(email, password);

      if (bloc.isLoggedIn) {
        Navigator.pushReplacementNamed(context, '/gallery');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: emailController,
                validator: _validateEmail,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: passwordController,
                validator: _validatePassword,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Senha'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _onSubmitHandler(context);
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
