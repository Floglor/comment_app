import 'dart:io';

import 'package:comment_app/models/commentary.dart';
import 'package:comment_app/providers/profile.dart';
import 'package:comment_app/screens/profile_edit_screen.dart';
import 'package:comment_app/screens/saved_images_screen.dart';
import 'package:provider/provider.dart';
import 'package:comment_app/widgets/commentary_widget.dart';
import 'package:comment_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
          ProfileEdit.routeName: (ctx) => ProfileEdit()
        },
        title: "CommentApp",
        home: MyHomePage(),
      ),
      providers: [
        ChangeNotifierProvider.value(
          value: PostsRepository(),
        ),
        ChangeNotifierProvider.value(
          value: Profile("User", File("assets/test_graphics/8kb6UL-FvxM.jpg")),
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
  File _image;
  bool isDataLoaded = false;
  static final List<Commentary> _commentaries = [];
  bool _isNewPostSelected = false;

  ImagePost imagePost = new ImagePost(null, _commentaries);
  ImagePost argumentImagePost;

  // static final List<Commentary> _commentaries = [l
  //   Commentary(date: DateTime.now(), text: "HOT <3", profileName: "Pepega"),
  //   Commentary(date: DateTime.now(), text: defaultText, profileName: "Pepega")
  // ];

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    print(image.path);
    final PostsRepository _posts = Provider.of<PostsRepository>(context);

    for (var i = 0; i < _posts.items.length; ++i) {
      var post = _posts.items[i];
      if (image.path == post.image.path) {
        _showSnackBar("This image is already added.");
        setState(() {
          imagePost = post;
          _image = post.image;
          argumentImagePost = post;
        });
        return;
      }
    }
    setState(() {
      imagePost = new ImagePost(image, new List<Commentary>());
      _image = image;
      _posts.addPost(imagePost);
      argumentImagePost = imagePost;
      print('new post created');
      _isNewPostSelected = true;
    });
  }

  _showSnackBar(String message) {
    _scaffoldState.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (!Provider.of<PostsRepository>(context).isActual) {
      Provider.of<PostsRepository>(context).loadDataFromDB();
      Provider.of<PostsRepository>(context).isActual = true;
    }

    // if (!isDataLoaded)
    // Provider.of<PostsRepository>(context).loadDataFromDB();
    // isDataLoaded = true;

    if (argumentImagePost == null) {
      argumentImagePost =
      ModalRoute
          .of(context)
          .settings
          .arguments as ImagePost;

      if (argumentImagePost!= null)
      imagePost = argumentImagePost;

    }

    if (argumentImagePost == null)
      print("ARGUMENT POST IS NULL");
    else
      print("ARGUMENT POST IS NOT NULL");

    if (argumentImagePost != null) {
      _image = argumentImagePost.image;
      imagePost = argumentImagePost;
    }


    return Scaffold(
        drawer: MainDrawer(),
        key: _scaffoldState,
        appBar: AppBar(
          title: Text("CommentApp"),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                getImage();
              },
              icon: Icon(Icons.image),
            ),
          ],
        ),
        body: ListView(
          children: <Widget>[ImageWidget(_image), CommentaryList(imagePost)],
        ));
  }
}
