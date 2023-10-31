import 'package:flutter_bloc/flutter_bloc.dart';

class UserEntity {
  final String uid;
  final String userName;
  final String email;
  final String profilePictureUrl;

  UserEntity(this.uid, this.email, this.profilePictureUrl, this.userName);

  static UserEntity getDummy() {
    return UserEntity("1", "email@email.com",
        "https://profilePictureUrl.app/photo.png", "tech tick");
  }
}

class AuthData<T extends Object> {
  final String? accessToken;
  final String? refreshToken;
  final String? bearerToken;
  final T? authOptions;

  AuthData(this.accessToken, this.refreshToken, this.bearerToken,
      {this.authOptions});

  static AuthData getDummy() {
    return AuthData("kgaowek23goalkm3oi4j123", "3o2k41oi5j12o31234opk412",
        "1po23kp412po43po");
  }
}

class AuthBlocState {
  String? get userId => user?.uid;
  UserEntity? user;
  AuthData? auth;

  AuthBlocState({this.auth, this.user});
}

// TODO: change for async methods.
class AuthBloc extends Cubit<AuthBlocState> {
  AuthBloc() : super(AuthBlocState());

  void logIn(String userName, String password) {
    emit(AuthBlocState(user: UserEntity.getDummy(), auth: AuthData.getDummy()));
  }

  void logOut() {
    emit(AuthBlocState(user: null, auth: null));
  }

  bool get isLoggedIn => state.auth != null && state.user != null;
}
