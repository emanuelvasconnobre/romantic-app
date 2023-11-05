import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projects/data/auth/protocols/authentication/protocols/credential_data.dart';
import 'package:projects/data/service/auth/auth_service.dart';
import 'package:projects/factories/services/auth_service_factory.dart';
import 'package:projects/utils/result_helper/result.dart';

class AuthBlocState extends CredentialData {
  AuthBlocState({super.auth, super.user});
}

class AuthBloc extends Cubit<AuthBlocState> {
  final AuthService authService = AuthServiceFactory.getInstanceFromFirebase();

  AuthBloc() : super(AuthBlocState());

  Future<void> logIn(String email, String password) async {
    final result = await authService.logIn(email, password);

    if (result is Success) {
      emit(AuthBlocState(user: result.data!.user!, auth: result.data!.auth));
    } else {
      Fluttertoast.showToast(
          msg: result.message.message,
          toastLength: Toast.LENGTH_SHORT, // Duração do Toast
          gravity: ToastGravity.BOTTOM, // Posição do Toast na tela
          timeInSecForIosWeb: 1, // Duração específica para iOS
          backgroundColor: Colors.red, // Cor de fundo do Toast
          textColor: Colors.white, // Cor do texto do Toast
          fontSize: 16.0 // Tamanho da fonte do texto do Toast
      );
    }
  }

  Future<void> logOut() async {
    emit(AuthBlocState(user: null, auth: null));
  }

  bool get isLoggedIn => state.auth != null && state.user != null;
}
