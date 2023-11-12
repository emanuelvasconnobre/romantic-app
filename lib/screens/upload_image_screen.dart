import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:romanticapp/bloc/auth_bloc.dart';
import 'package:romanticapp/bloc/gallery_bloc.dart';
import 'package:romanticapp/data/service/photo/protocols/create_one_service_input.dart';

class UploadImageScreen extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final BuildContext parentContext;

  const UploadImageScreen(
      {required this.navigatorKey, required this.parentContext, super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  late bool _isLoading = false;

  late GalleryBloc _galleryBloc;
  late AuthBloc _authBloc;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _image;
  final picker = ImagePicker();
  final TextEditingController _descriptionController = TextEditingController();

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
      if (_formKey.currentState!.validate() && _image != null) {
        String description = _descriptionController.text;

        await _galleryBloc.addOnePhoto(CreateOneServiceInput(
            image: _image!,
            description: description,
            userId: _authBloc.state.user!.uid));

        setState(() {
          _isLoading = false;
          _descriptionController.clear();
          _image = null;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _galleryBloc = getGalleryBloc(widget.parentContext);
    _authBloc = getAuthBloc(widget.parentContext);
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
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descrição',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira uma descrição';
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
                  child: const Text('Enviar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

