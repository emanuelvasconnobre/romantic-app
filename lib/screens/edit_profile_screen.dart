import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:romanticapp/bloc/auth_bloc.dart';
import 'package:romanticapp/data/service/user/protocols/update_profile_service_input.dart';

class EditProfileScreen extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final BuildContext parentContext;

  const EditProfileScreen(
      {required this.navigatorKey, required this.parentContext, super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late bool _isLoading = false;

  late AuthBloc _authBloc;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _image;
  final picker = ImagePicker();
  late TextEditingController _nameController;
  late TextEditingController _bioController;

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      if (_formKey.currentState!.validate()) {
        String name = _nameController.text;
        String bio = _bioController.text;

        var input = UpdateProfileUserServiceInput(
          profilePicture: _image,
          name: name,
          bio: bio,
        );

        await _authBloc.editProfile(input);

        setState(() {
          _isLoading = false;
          widget.navigatorKey.currentState?.pop();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _authBloc = getAuthBloc(widget.parentContext);
    _nameController = TextEditingController(text: _authBloc.state.user?.name);
    _bioController = TextEditingController(text: _authBloc.state.user?.bio);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            const Text("Dados do usuário", style: TextStyle(fontSize: 24.0)),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(right: 15.0),
                    child: _image != null
                        ? CircleAvatar(
                            radius: 50.0,
                            backgroundImage: FileImage(
                              _image!,
                            ))
                        : CircleAvatar(
                            radius: 50.0,
                            backgroundColor: Colors.blue,
                            child: ClipOval(
                              child: AspectRatio(
                                  aspectRatio: 1.5,
                                  child: Image.asset(
                                    "assets/images/pick-image-icon.png",
                                    fit: BoxFit.contain,
                                  )),
                            ),
                          )),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: getImage,
                  child: const Text('Selecionar Imagem'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              enabled: !_isLoading,
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira uma nome';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _bioController,
              enabled: !_isLoading,
              decoration: const InputDecoration(
                labelText: 'Bio',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira uma bio';
                }
                return null;
              },
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_isLoading) const CircularProgressIndicator(),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
