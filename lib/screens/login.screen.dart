import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:romanticapp/bloc/auth_bloc.dart';
import 'package:romanticapp/validation/composite.validation.dart';
import 'package:romanticapp/validation/form/email.validation.dart';
import 'package:romanticapp/validation/form/is_not_empty.validation.dart';
import 'package:romanticapp/validation/form/min_length.validation.dart';

class LoginScreen extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const LoginScreen({required this.navigatorKey, super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  late bool _isLoading = false;

  AuthBloc? _authBloc;

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

  void _onSubmitHandler(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final email = emailController.text;
      final password = passwordController.text;

      await _authBloc?.logIn(email, password);

      if (_authBloc != null && _authBloc!.isLoggedIn) {
        widget.navigatorKey.currentState?.pushNamed('/gallery');
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _authBloc ??= BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: emailController,
                enabled: !_isLoading,
                validator: _validateEmail,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: passwordController,
                enabled: !_isLoading,
                validator: _validatePassword,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Senha'),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_isLoading) const CircularProgressIndicator(),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      _onSubmitHandler(context);
                    },
                    child: const Text('Enviar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
