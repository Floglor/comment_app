import 'package:comment_app/models/commentary.dart';
import 'package:comment_app/widgets/commentary_widget.dart';
import 'package:flutter/material.dart';
import 'widgets/image.dart';
import 'models/commentary.dart';

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CommentApp"),
      ),
      body: ListView(
            children: <Widget>[
              ImageWidget(),
              CommentaryList()
        ],
      )
    );
  }
}
