import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:romanticapp/data/auth/protocols/authentication/protocols/credential_data.dart';
import 'package:romanticapp/data/datasource/protocols/entities/user_entity.dart';
import 'package:romanticapp/data/service/auth/auth_service.dart';
import 'package:romanticapp/data/service/user/protocols/update_profile_service_input.dart';
import 'package:romanticapp/data/service/user/user_service.dart';
import 'package:romanticapp/factories/services/auth_service_factory.dart';
import 'package:romanticapp/factories/services/user_service_factory.dart';
import 'package:romanticapp/utils/result_helper/result.dart';

AuthBloc getAuthBloc(BuildContext context) {
  return BlocProvider.of(context);
}

class AuthBlocState extends CredentialData {
  AuthBlocState({super.auth, super.user});
}

class AuthBloc extends Cubit<AuthBlocState> {
  final AuthService authService = AuthServiceFactory.getInstance();
  final UserService userService = UserServiceFactory.getInstance();

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
    Result result = await authService.logOut();

    if (result is Success) {
      emit(AuthBlocState(user: null, auth: null));

      Fluttertoast.showToast(
          msg: result.message.message,
          toastLength: Toast.LENGTH_SHORT, // Duração do Toast
          gravity: ToastGravity.BOTTOM, // Posição do Toast na tela
          timeInSecForIosWeb: 1, // Duração específica para iOS
          backgroundColor: Colors.green, // Cor de fundo do Toast
          textColor: Colors.white, // Cor do texto do Toast
          fontSize: 16.0 // Tamanho da fonte do texto do Toast
          );
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

  Future<void> editProfile(UpdateProfileUserServiceInput input) async {
    if (state.user == null) return;

    final result = await userService.updateProfile(state.user!.uid, input);

    if (result is Success) {
      UserEntity newUser = UserEntity.copy(state.user!);
      if (input.name != null) newUser.name = input.name!;
      if (input.bio != null) newUser.name = input.bio!;
      if (result.data?.profilePictureUrl != null) newUser.profilePictureUrl = result.data!.profilePictureUrl!;
      emit(AuthBlocState(user: newUser, auth: state.auth));
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

  bool get isLoggedIn => state.auth != null && state.user != null;
}

class AuthBlocBuilder extends BlocBuilder<AuthBloc, AuthBlocState> {
  AuthBlocBuilder({
    Key? key,
    required BuildContext context,
    BlocBuilderCondition<AuthBlocState>? buildWhen,
    required Widget Function(BuildContext, AuthBlocState) builder,
  }) : super(
          key: key,
          bloc: BlocProvider.of<AuthBloc>(context),
          builder: builder,
          buildWhen: buildWhen,
        );
}
