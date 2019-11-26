import 'package:comment_app/models/commentary.dart';
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
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        routes: {
          SavedImages.routeName: (ctx) => SavedImages(),
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
  var _image;

  ImagePost imagePost = new ImagePost(
      new AssetImage("assets/test_graphics/8kb6UL-FvxM.jpg"), _commentaries);

  static final List<Commentary> _commentaries = [
    Commentary(date: DateTime.now(), text: "HOT <3", profileName: "Pepega"),
    Commentary(date: DateTime.now(), text: defaultText, profileName: "Pepega")
  ];

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    final _posts = Provider.of<PostsRepository>(context);
    setState(() {
      imagePost = new ImagePost(image, new List<Commentary>());
      _image = image;
      _posts.addPost(imagePost);
    });
  }

  @override
  Widget build(BuildContext context) {
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
