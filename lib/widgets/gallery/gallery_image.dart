import 'package:flutter/material.dart';
import 'package:projects/bloc/protocols/local_photo.dart';
import 'package:projects/widgets/UI/live_container_loading.dart';

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
        if (_loading) const LiveContainerLoading(),
        if (!_loading)
          Image.network(
            widget.localPhoto.photo.imageUrl,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                _loading = false;
                return child;
              } else {
                _loading = true;
                return const LiveContainerLoading();
              }
            },
          ),
      ],
    );
  }
}
