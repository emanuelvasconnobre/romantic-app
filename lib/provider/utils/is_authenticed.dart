import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/bloc/auth_bloc.dart';

bool isAuthenticated(BuildContext context) {
  final bloc = BlocProvider.of<AuthBloc>(context);

  return bloc.isLoggedIn;
}
