import 'package:flutter/material.dart';
import 'package:projects/bloc/protocols/local_photo.dart';

class GalleryImage extends StatefulWidget {
  final LocalPhoto localPhoto;

  const GalleryImage({required this.localPhoto, super.key});

  @override
  State<GalleryImage> createState() => _GalleryImageState();
}

class _GalleryImageState extends State<GalleryImage> {
  late bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.network(
          widget.localPhoto.photo.imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              _loading = false;
              return child;
            } else {
              _loading = true;
              return const CircularProgressIndicator();
            }
          },
        ),
        if (_loading)
          const CircularProgressIndicator(),
      ],
    );
  }
}