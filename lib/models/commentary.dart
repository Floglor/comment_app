

import 'package:flutter/widgets.dart';

class Commentary {
  String commentaryId = DateTime.now().toString();
  String profileName;
  DateTime date;
  String text;

  Commentary({
    @required this.date,
    @required this.text,
    @required this.profileName,
  });

  Map<String, dynamic> toJson() => {
        'commentaryId': this.commentaryId.toString(),
        'profileName': this.profileName.toString(),
        'date': this.date.toString(),
        'text': this.text.toString()
      };

  Commentary.fromJson(Map<String, dynamic> json)
      : commentaryId = json['commentaryId'],
        profileName = json['profileName'],
        date = DateTime.parse(json['date']),
        text = json['text'];
}
