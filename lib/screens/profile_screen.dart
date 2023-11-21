import 'package:flutter/material.dart';
import 'package:romanticapp/bloc/auth_bloc.dart';
import 'package:romanticapp/screens/edit_profile_screen.dart';
import 'package:romanticapp/utils/app_color.dart';

class ProfileScreen extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final BuildContext parentContext;

  const ProfileScreen(
      {required this.navigatorKey, required this.parentContext, super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late AuthBloc _authBloc;

  void profileEditOnPressHandler() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext builderContext) {
        return EditProfileScreen(
          navigatorKey: widget.navigatorKey,
          parentContext: widget.parentContext,
        );
      },
    );
  }

  void logOutOnPressHandler() async {
    await _authBloc.logOut();

    if (!_authBloc.isLoggedIn) {
      widget.navigatorKey.currentState?.pushNamed('/login');
    }
  }

  @override
  void initState() {
    super.initState();
    _authBloc = getAuthBloc(widget.parentContext);
  }

  @override
  Widget build(BuildContext context) {
    return AuthBlocBuilder(
        context: widget.parentContext,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 15.0),
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundColor: AppColor.primaryBgColor,
                        backgroundImage: NetworkImage(state.user!
                            .profilePictureUrl), // Substitua pelo caminho da sua imagem de perfil
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.user!.name,
                            style: const TextStyle(fontSize: 24.0),
                            overflow: TextOverflow.clip,
                          ),
                          Text(
                            state.user!.userName,
                            style: const TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: profileEditOnPressHandler,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.tertiaryBgColor,
                  ),
                  child: const Text('Dados de Perfil'),
                ),
                Expanded(
                  child: Container(),
                ),
                ElevatedButton(
                  onPressed: logOutOnPressHandler,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.secondaryBgColor,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Sair',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
