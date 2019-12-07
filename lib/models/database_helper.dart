import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'commentary.dart';

// database table and column names
final String tablePaths = 'paths';
final String columnId = '_id';
final String columnPath = 'path';
final String columnCommentaries = 'commentaries';

// data model class
class Path {
  int id;
  String path;
  String postId;
  List<Commentary> commentaries;

  Path();

  String _commentariesToJson(List<Commentary> list) {
    String jsonString;
    List jsonList = List();
    list.map((item) => jsonList.add(item.toJson())).toList();
    jsonString = jsonList.toString();
    return jsonString;
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
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnPath: path,
      columnCommentaries: _commentariesToJson(commentaries),
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

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tablePaths (
                $columnId INTEGER PRIMARY KEY,
                $columnPath TEXT NOT NULL,
                $columnCommentaries TEXT NOT NULL
              )
              ''');
  }

  // Database helper methods:

  Future<int> insert(Path path) async {
    Database db = await database;
    int id = await db.insert(tablePaths, path.toMap());
    return id;
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

// TODO: queryAllWords()
// TODO: delete(int id)
// TODO: update(Word word)
}
