import 'dart:io';

import 'package:flutter/material.dart';

class ImageWidget extends StatefulWidget {
  final File _imageFile;

  ImageWidget(this._imageFile);

  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    var _image;
    if (widget._imageFile == null) {
      _image = new AssetImage("assets/test_graphics/8kb6UL-FvxM.jpg");
    }
    else {
      _image = new FileImage(widget._imageFile);
    }
    return Card(
      elevation: 5,
      child: Image(
        image: _image,
        fit: BoxFit.cover,
      ),
    );
  }
}
