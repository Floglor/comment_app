import 'dart:convert';
import 'dart:io';
import 'package:comment_app/models/image_post.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'commentary.dart';

// database table and column names
final String tablePaths = 'paths';
final String columnId = '_id';
final String columnPath = 'path';
final String columnCommentaries = 'commentaries';
final String columnPostID = 'postID';


String commentariesToJson(List<Commentary> list) {
  String jsonString;
  List jsonList = List();
  list.map((item) => jsonList.add(item.toJson())).toList();
  jsonString = jsonList.toString();
  return jsonString;
}

// data model class
class Path {
  int id;
  String path;
  String postId;
  List<Commentary> commentaries;

  Path();


  void updateCommentaries(List<Commentary> commList, String path) {

  }

  List<Commentary> _jsonToCommentary(String data) {
    List<Commentary> comments = List<Commentary>();
    List<dynamic> parsedJson = jsonDecode(data);
    comments = parsedJson.map((i) => Commentary.fromJson(i)).toList();
    return comments;
  }

  // convenience constructor to create a Path object
  Path.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    path = map[columnPath];
    commentaries = _jsonToCommentary(map[columnCommentaries]);
    postId = map[columnPostID];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnPath: path,
      columnCommentaries: commentariesToJson(commentaries),
      columnPostID: postId,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}

// singleton class to manage the database
class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";

  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  dropDB() async {
    Database db = await database;
    db.close();
    //db.execute("DROP DATABASE $_databaseName");
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, _databaseName);
    deleteDatabase(path);
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  deleteAllPaths() async {
    Database db = await database;
    db.rawDelete("Delete from $tablePaths");
  }
  
  deleteByPostId(String postID) async {
    Database db = await database;
    db.rawDelete("Delete from $tablePaths where $columnPostID='$postID'");
  }

  Future<int> updateByID(ImagePost imagePost) async {
    Database db = await database;
    var row = {
      columnPostID : imagePost.postId,
      columnCommentaries : commentariesToJson(imagePost.commentaries),
      columnPath : imagePost.image.path,
    };

    return await db.update(tablePaths, row, where: '$columnPostID = ?', whereArgs: [imagePost.postId]);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tablePaths (
                $columnId INTEGER PRIMARY KEY,
                $columnPath TEXT NOT NULL,
                $columnCommentaries TEXT NOT NULL,
                $columnPostID TEXT NOT NULL
              )
              ''');
  }

  // Database helper methods:

  Future<int> insert(Path path) async {
    Database db = await database;
    int id = await db.insert(tablePaths, path.toMap());
    return id;
  }

   Future<List<Path>> getAllPaths() async {
    final db = await database;
    var res = await db.query(tablePaths);
    List<Path> list =
    res.isNotEmpty ? res.map((c) => Path.fromMap(c)).toList() : [];
    return list;
  }

  Future<Path> queryPath(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tablePaths,
        columns: [columnId, columnPath, columnCommentaries],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Path.fromMap(maps.first);
    }
    return null;
  }

// TODO: delete(int id)
// TODO: update(Word word)
}
