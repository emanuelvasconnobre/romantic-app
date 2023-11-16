import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:romanticapp/bloc/auth_bloc.dart';
import 'package:romanticapp/data/service/user/protocols/update_profile_service_input.dart';

class EditProfileScreen extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final BuildContext parentContext;

  const EditProfileScreen(
      {required this.navigatorKey,
      required this.parentContext,
      super.key});

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

        await _authBloc.editProfile(UpdateProfileUserServiceInput(
          profilePicture: _image,
          bio: name,
          name: bio,
        ));

        setState(() {
          _isLoading = false;
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
            TextFormField(
              controller: _nameController,
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: getImage,
              child: const Text('Selecionar Imagem'),
            ),
            const SizedBox(height: 10),
            _image != null
                ? Image.file(
                    fit: BoxFit.contain,
                    _image!,
                    height: 150,
                  )
                : Container(),
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