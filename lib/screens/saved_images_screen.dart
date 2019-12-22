import 'package:comment_app/main.dart';
import 'package:comment_app/models/image_post.dart';
import 'package:comment_app/providers/posts_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedImages extends StatefulWidget {
  static const routeName = "/saved_images";

  @override
  _SavedImagesState createState() => _SavedImagesState();
}

class _SavedImagesState extends State<SavedImages> {
  @override
  Widget build(BuildContext context) {

    List<ImagePost> imagePosts = Provider.of<PostsRepository>(context).items;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                Provider.of<PostsRepository>(context).deleteAllImagePosts();
                // TODO: execute if database structure somehow changed Provider.of<PostsRepository>(context).deleteDB();
              });
            },
            icon: Icon(Icons.delete),
          )
        ],
        title: Text("Saved Images"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: imagePosts.length,
        itemBuilder: (ctx, i) => GestureDetector(
            onTap: () => Navigator.of(context)
                .pushNamed(MyApp.routeName, arguments: imagePosts[i]),
            child: Image(
              image: FileImage(imagePosts[i].image),
              height: 60,
              fit: BoxFit.cover,
            )),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          //childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
