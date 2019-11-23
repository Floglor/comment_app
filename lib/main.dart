import 'package:comment_app/models/commentary.dart';
import 'package:comment_app/widgets/commentary_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'widgets/image.dart';
import 'models/commentary.dart';

enum FilterOptions { ImagePick }


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "LmaoApp",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("CommentApp"),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                getImage();
              },
              icon: Icon(Icons.image),
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
            ImageWidget(_image),
            CommentaryList()
          ],
        ));
  }
}
