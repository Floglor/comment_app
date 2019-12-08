import 'dart:io';

import 'package:comment_app/models/database_helper.dart';
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
    _saveToDB(imagePost);
    _readFromDB();
  }

  loadDataFromDB(){
    DatabaseHelper helper = DatabaseHelper.instance;
    List<Path> pathList = helper.getAllPaths();
    List<ImagePost> imageList = pathList.map((pathItem) => new ImagePost(new File(pathItem.path), pathItem.commentaries));
    _items = imageList;
  }

  _saveAllToDB() async {
    Path path = Path();
    DatabaseHelper helper = DatabaseHelper.instance;
    int id;
    for (int i = 0; i < _items.length; i++) {
      path.path = _items[i].image.path;
      path.commentaries = _items[i].commentaries;
      path.postId = _items[i].postId;
      id = await helper.insert(path);
      print('inserted row: $id');
    }
  }

  deleteAllImagePosts(){
    DatabaseHelper helper = DatabaseHelper.instance;
    helper.deleteAllPaths();
    _items.clear();
    print("database cleared, _items cleared");
  }

  _saveToDB(ImagePost imagePost) async {
    Path path = Path();
    DatabaseHelper helper = DatabaseHelper.instance;
    int id;

    path.path = imagePost.image.path;
    path.commentaries = imagePost.commentaries;
    path.postId = imagePost.postId;
    id = await helper.insert(path);
    print('inserted row: $id');
  }

  _readFromDB() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    int rowId = 1;
    Path path = await helper.queryPath(rowId);
    if (path == null) {
      print('read row $rowId: empty');
    } else {
      print('read row $rowId: ${path.path} ${path.id}');
    }
  }
}
