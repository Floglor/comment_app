import 'package:comment_app/models/image_post.dart';
import 'package:comment_app/providers/posts_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedImages extends StatelessWidget {
  static const routeName = "/saved_images";

  @override
  Widget build(BuildContext context) {
    List<ImagePost> imagePosts = Provider.of<PostsRepository>(context).items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: imagePosts.length,
      itemBuilder: (ctx, i) => Image(image: FileImage(imagePosts[i].image), height: 60, width: 60,),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        //childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
