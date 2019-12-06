import 'package:flutter/cupertino.dart';

class Commentary {
  String commentaryId = DateTime.now().toString();
  String profileName;
  DateTime date;
  String text;

  Commentary(
      {@required this.date, @required this.text, @required this.profileName,});

  Map<String, dynamic> toJson() =>
      {
        'commentaryId': this.commentaryId,
        'profileName': this.profileName,
        'date': this.date,
        'text': this.text
      };

  Commentary.fromJson(Map<String, dynamic> json)
  : profileName = json['profileName'],
    date = DateTime.parse(json['date']),
    text = json['text'];



}
