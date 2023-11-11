import 'package:flutter/material.dart';
import 'package:ayane/data/datasource/protocols/entities/photo_entity.dart';
import 'package:ayane/widgets/UI/live_container_loading.dart';

class GalleryImage extends StatefulWidget {
  final PhotoEntity photo;

  const GalleryImage({required this.photo, super.key});

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
            widget.photo.imageUrl,
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
