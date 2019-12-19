import 'package:comment_app/models/image_post.dart';
import 'package:comment_app/providers/posts_repo.dart';
import 'package:comment_app/providers/profile.dart';
import 'package:comment_app/widgets/main_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/commentary.dart';
import 'comment_container.dart';
import 'newcomm.dart';

const String defaultText =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

class CommentaryList extends StatefulWidget {
  final ImagePost imagePost;

  CommentaryList(this.imagePost);

  @override
  _CommentaryListState createState() => _CommentaryListState();
}

class _CommentaryListState extends State<CommentaryList> {
  void _addNewCommentary(String text) {
    final newCom =
        Commentary(date: DateTime.now(), text: text, profileName: Provider.of<Profile>(context).login);

    setState(() {
      widget.imagePost.commentaries.add(newCom);
    });

    Provider.of<PostsRepository>(context).updatePost(widget.imagePost);
  }

  @override
  Widget build(BuildContext context) {
    ImagePost _imagePost = widget.imagePost;
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    var avatarBorderRadius;

    if (isLandscape) {
      avatarBorderRadius = mediaQuery.size.width * 0.04;
    } else {
      avatarBorderRadius = mediaQuery.size.width * 0.08;
    }

    return Container(
      //height: 300,
      child: Column(children: <Widget>[
        ListView.builder(
          itemCount: _imagePost.commentaries.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (ctx, index) => Container(
              margin: EdgeInsets.only(bottom: 1.5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MainAvatar(0.04, null),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: mediaQuery.size.width - avatarBorderRadius - 50,
                    child: CommentaryContainer(_imagePost.commentaries, index),
                  )
                ],
              )),
        ),
        NewCommentary(_addNewCommentary)
      ]),
    );
  }
}
