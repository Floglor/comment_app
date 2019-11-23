import 'package:flutter/cupertino.dart';

class Commentary {
  String commentaryId = DateTime.now().toString();
  String profileName;
  DateTime date;
  String text;

  Commentary({@required this.date, @required this.text, @required this.profileName,});
}
