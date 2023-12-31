import 'package:local_db/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static late Database _database;
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  static const String _tableName = 'notes';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'note_db.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName (id INTEGER PRIMARY KEY, title TEXT, description TEXT)''',
        );
      },
      version: 1,
    );
    return db;
  }

  Future<void> insertNote(Note note) async {
    final Database db = await database;
    await db.insert(_tableName, note.toMap());
    print('Data Saved');
  }

  Future<List<Note>> getNotes() async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.query(_tableName);
    return result.map((e) => Note.fromMap(e)).toList();
  }

  Future<Note> getNotebyId(int id) async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return result.map((e) => Note.fromMap(e)).first;
  }

  Future<void> updateNote(Note note) async {
    final Database db = await database;

    await db.update(
      _tableName,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> deleteNote(int id) async {
    final Database db = await database;

    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
