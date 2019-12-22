import 'dart:io';

import 'package:comment_app/models/database_helper.dart';
import 'package:comment_app/models/image_post.dart';
import 'package:flutter/widgets.dart';

class PostsRepository with ChangeNotifier {
  static const String _key = 'PostRepo';

  bool isActual = false;

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

  void deleteDB() {
    DatabaseHelper helper = DatabaseHelper.instance;
    helper.dropDB();

  }

  void updatePost(ImagePost imagePost) {
    DatabaseHelper helper = DatabaseHelper.instance;
    helper.updateByID(imagePost);
    String logCommentaries = imagePost.commentaries[0].text;
    print("Commentary of $logCommentaries Uploaded");
  }

  loadDataFromDB() {
    DatabaseHelper helper = DatabaseHelper.instance;
    helper.getAllPaths().then((onValue) {
      if (onValue != null) {
        List<ImagePost> imageList = onValue.map((pathItem) =>
        new ImagePost.withPostId(new File(pathItem.path), pathItem.commentaries, pathItem.postId)).toList();
       // for (int i = 0; i < imageList.length; i++)
       //   for (int j = 0; j<imageList[i].commentaries.length; j++)
       //     print(imageList[i].commentaries[j].text);
        _items = imageList;
        print("Data loaded");
      }
      else {
        print("onValue = null");
      }
    });
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

  deleteAllImagePosts() {
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
