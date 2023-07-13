import 'package:news_provider/data/model/article.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static DataBaseHelper? _instance;
  static Database? _database;

  DataBaseHelper._internal() {
    _instance = this;
  }

  factory DataBaseHelper() => _instance ?? DataBaseHelper._internal();

  static const String _tblBookmark = 'bookmarks';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/newsapp.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblBookmark (
             url TEXT PRIMARY KEY,
             author TEXT,
             title TEXT,
             description TEXT,
             urlToImage TEXT,
             publishedAt TEXT,
             content TEXT
           )     
        ''');
      },
      version: 1,
    );

    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();

    return _database;
  }

  Future<void> insertBookmark(Article article) async {
    final db = await database;
    await db!.insert(_tblBookmark, article.toJson());
  }

  Future<List<Article>> getBookmarks() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblBookmark);

    return results.map((res) => Article.fromJson(res)).toList();
  }

  Future<Map> getBookmarkByUrl(String url) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _tblBookmark,
      where: 'url = ?',
      whereArgs: [url],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeBookmark(String url) async {
    final db = await database;

    await db!.delete(
      _tblBookmark,
      where: 'url = ?',
      whereArgs: [url],
    );
  }
}