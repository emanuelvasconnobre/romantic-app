import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/data/auth/protocols/authentication/protocols/credential_data.dart';
import '../data/datasource/protocols/entities/user_entity.dart';

class AuthBlocState extends CredentialData {
  AuthBlocState({super.auth, super.user});
}

// TODO: change for async methods.
class AuthBloc extends Cubit<AuthBlocState> {
  AuthBloc() : super(AuthBlocState());

  void logIn(String userName, String password) async {
    emit(AuthBlocState(user: UserEntity.getDummy(), auth: AuthData.getDummy()));
  }

  void logOut() async {
    emit(AuthBlocState(user: null, auth: null));
  }

  bool get isLoggedIn => state.auth != null && state.user != null;
}
