import 'package:flutter/material.dart';
import 'package:romanticapp/bloc/auth_bloc.dart';

class ProfileScreen extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final BuildContext parentContext;

  const ProfileScreen(
      {required this.navigatorKey, required this.parentContext, super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late bool _isLoading = false;

  late AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = getAuthBloc(widget.parentContext);
  }

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
              "fawefawf"
          ),
        )
    );
  }
}
