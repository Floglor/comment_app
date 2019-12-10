import 'dart:io';

import 'package:flutter/widgets.dart';

class Profile with ChangeNotifier {
  String login;
  File avatar;

  Profile(this.login, this.avatar);
}