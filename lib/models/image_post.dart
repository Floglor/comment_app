import 'dart:io';

import 'package:comment_app/models/commentary.dart';

class ImagePost {
  String postId = DateTime.now().toString();
  File image;
  List<Commentary> commentaries;

  ImagePost(this.image, this.commentaries);


}