import 'dart:io';

import 'package:comment_app/models/commentary.dart';
import 'package:comment_app/screens/saved_images_screen.dart';
import 'package:provider/provider.dart';
import 'package:comment_app/widgets/commentary_widget.dart';
import 'package:comment_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'models/database_helper.dart';
import 'models/image_post.dart';
import 'widgets/image.dart';
import 'models/commentary.dart';
import './providers/posts_repo.dart';


enum FilterOptions { ImagePick }

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String routeName = "ImageScreen";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        routes: {
          SavedImages.routeName: (ctx) => SavedImages(),
          routeName: (ctx) => MyHomePage(),
        },
        title: "LmaoApp",
        home: MyHomePage(),
      ),
      providers: [
        ChangeNotifierProvider.value(
          value: PostsRepository(),
        )
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  _read() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    int rowId = 1;
    Path path = await helper.queryPath(rowId);
    if (path == null) {
      print('read row $rowId: empty');
    } else {
    //  print('read row $rowId: ${path.path} ${path.}');
    }
  }

  _save(ImagePost post) async {
    Path path = Path();
    path.path = 'hello';
    DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.insert(path);
    print('inserted row: $id');
  }

  var _image;
  static final List<Commentary> _commentaries = [];
  bool _isNewPostSelected = false;


  ImagePost imagePost = new ImagePost(
      null, _commentaries);

  // static final List<Commentary> _commentaries = [
  //   Commentary(date: DateTime.now(), text: "HOT <3", profileName: "Pepega"),
  //   Commentary(date: DateTime.now(), text: defaultText, profileName: "Pepega")
  // ];

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    print(image.path);
    final PostsRepository _posts = Provider.of<PostsRepository>(context);
   // final repoPostList = _posts.items;

   // bool isAlreadyPosted = false;
   // for (int i = 0; i < repoPostList.length; i++) {
   //     if (repoPostList[i].image.) {
   //     isAlreadyPosted = true;
   //     print('already posted');
   //   }
   // }
   // if (!isAlreadyPosted)

      setState(() {
        imagePost = new ImagePost(image, new List<Commentary>());
        _image = image;
        _posts.addPost(imagePost);
        print('new post created');
        _isNewPostSelected = true;

      });
  }

  @override
  Widget build(BuildContext context) {
    ImagePost argumentImagePost =
        ModalRoute.of(context).settings.arguments as ImagePost;
    if (argumentImagePost != null) {
      _image = argumentImagePost.image;
      imagePost = argumentImagePost;
    }

    return Scaffold(
        drawer: MainDrawer(),
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
          children: <Widget>[ImageWidget(_image), CommentaryList(imagePost)],
        ));
  }
}
