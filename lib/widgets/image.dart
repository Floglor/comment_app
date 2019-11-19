import 'package:flutter/material.dart';

class ImageWidget extends StatefulWidget {
  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Image(
        image: new AssetImage("assets/test_graphics/8kb6UL-FvxM.jpg"),
        fit: BoxFit.cover,
      ),
    );
  }
}
