import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/commentary.dart';
import 'comment_container.dart';
import 'newcomm.dart';



const String defaultText =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

class CommentaryList extends StatefulWidget {
  @override
  _CommentaryListState createState() => _CommentaryListState();
}

class _CommentaryListState extends State<CommentaryList> {
  final List<Commentary> _commentaries = [
    Commentary(date: DateTime.now(), text: "HOT <3", profileName: "Pepega"),
    Commentary(date: DateTime.now(), text: defaultText, profileName: "Pepega")
  ];

  void _addNewCommentary(String text) {
    final newCom =
        Commentary(date: DateTime.now(), text: text, profileName: "Pepega");

    setState(() {
      _commentaries.add(newCom);
    });
  }

  Widget _buildLandscapeContent (
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget txListWidget,
  ) {}



  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    var avatarBorderRadius;
    if (isLandscape) {
      avatarBorderRadius = mediaQuery.size.width * 0.04;
    }
    else {
      avatarBorderRadius = mediaQuery.size.width * 0.08;
    }
    var avatarDiameter = avatarBorderRadius*1.7;

    return Container(
      //height: 300,
      child: Column(children: <Widget>[
        ListView.builder(
          itemCount: _commentaries.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (ctx, index) => Container(
              margin: EdgeInsets.only(bottom: 1.5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    radius: avatarBorderRadius,
                    child: Container(
                      width: avatarDiameter,
                      height: avatarDiameter,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new AssetImage(
                              "assets/test_graphics/8kb6UL-FvxM.jpg"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: mediaQuery.size.width-avatarBorderRadius-50,
                    child: CommentaryContainer(_commentaries, index)
                  ,)
                ],
              )),
        ),
        NewCommentary(_addNewCommentary)
      ]),
    );
  }
}
