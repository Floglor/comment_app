import 'package:comment_app/models/commentary.dart';
import 'package:comment_app/widgets/commentary_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentaryContainer extends StatelessWidget {

  List<Commentary> _commentaryList;
  int index;


  CommentaryContainer(this._commentaryList, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 295,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _commentaryList[index].profileName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text(_commentaryList[index].text),
            SizedBox(
              height: 5,
            ),
            Text(
              DateFormat.yMd().format(_commentaryList[index].date),
              style: TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ],
        ));
  }
}
