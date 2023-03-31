import 'package:flutter/material.dart';

class ImageComic extends StatefulWidget {
  String path;
  ImageComic(this.path);
  @override
  _ImageComicState createState() => _ImageComicState();
}

class _ImageComicState extends State<ImageComic> {
  final _transformationController = TransformationController();
  TapDownDetails? _doubleTapDetails;

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails!.localPosition;
      // For a 3x zoom
      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(2.5);
      // Fox a 2x zoom
      // ..translate(-position.dx, -position.dy)
      // ..scale(2.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTapDown: _handleDoubleTapDown,
      onDoubleTap: _handleDoubleTap,
      child: InteractiveViewer(
        transformationController: _transformationController,
        child: FadeInImage(
            fadeInDuration: const Duration(milliseconds: 1),
            placeholder: const AssetImage('assets/images/loading.gif'),
            image: NetworkImage(widget.path)),
      ),
    );
  }
}
