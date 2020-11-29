import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// database table and column names
final String tableNotes = 'note';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnContent = 'content';

// data model class
class Note {

  int id;
  String title;
  String content;

  Note(this.id, this.title, this.content);

  // convenience constructor to create a Word object
  Note.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    title = map[columnTitle];
    content = map[columnContent];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnContent: content
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
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableNotes (
                $columnId INTEGER PRIMARY KEY,
                $columnTitle TEXT NOT NULL,
                $columnContent TEXT NOT NULL
              )
              ''');
  }

  // Database helper methods:

  Future<int> insert(Note note) async {
    Database db = await database;
    int id = await db.insert(tableNotes, note.toMap());
    return id;
  }

  Future<Note> queryNote(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableNotes,
        columns: [columnId, columnTitle, columnContent],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Note.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Note>> queryAllNotes() async {
    Database db = await database;
    List<Map> maps = await db.query(tableNotes);
    if (maps.length > 0) {
      List<Note> notes = [];
      maps.forEach((map) => notes.add(Note.fromMap(map)));
      return notes;
    }
    return null;
  }

  Future<int> deleteNote(int id) async {
    Database db = await database;
    return await db.delete(tableNotes, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Note word) async {
    Database db = await database;
    return await db.update(tableNotes, word.toMap(),
        where: '$columnId = ?', whereArgs: [word.id]);
  }

}