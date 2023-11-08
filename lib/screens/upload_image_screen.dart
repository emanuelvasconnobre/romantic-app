import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageScreen extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const UploadImageScreen({required this.navigatorKey, super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  late bool _isLoading = false;

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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      // Simulando um envio de dados com um atraso de 3 segundos
      Future.delayed(const Duration(seconds: 3), () {
        if (_formKey.currentState!.validate() && _image != null) {
          String description = _descriptionController.text;

          if (kDebugMode) {
            print(description);
          }
        }
        setState(() {
          _isLoading = false;
          _descriptionController.clear();
          _image = null;
        });
      });
    }
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
