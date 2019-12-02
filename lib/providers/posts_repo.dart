import 'package:comment_app/models/image_post.dart';
import 'package:flutter/cupertino.dart';

class PostsRepository with ChangeNotifier {

  static const String _key = 'PostRepo';

  List<ImagePost> _items = [];

  List<ImagePost> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  void addPost(ImagePost imagePost) {
    _items.add(imagePost);
    notifyListeners();
  }

  _saveToDB() async {}

  _readFromDB() async {
  }
}
