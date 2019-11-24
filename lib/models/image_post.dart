import 'package:comment_app/models/commentary.dart';

class ImagePost {
  String postId = DateTime.now().toString();
  var image;
  List<Commentary> commentaries;

  ImagePost(this.image, this.commentaries);


}