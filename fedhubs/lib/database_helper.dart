import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = 'my_database.db';
  static final _databaseVersion = 1;

  static final table = 'products';
  static final columnId = '_id';
  static final columnName = 'name';
  static final columnPrice = 'price';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    return _database ??= await _initDatabase();
  }

  // open the database
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnPrice REAL NOT NULL
          )
          ''');
  }

  // Database helper methods:

  Future<int> insertProduct(String name, double price) async {
    Database db = await database;
    Map<String, dynamic> row = {
      columnName: name,
      columnPrice: price,
    };
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllProducts() async {
    Database db = await database;
    return await db.query(table);
  }

  Future<int> updateProduct(int id, String name, double price) async {
    Database db = await database;
    Map<String, dynamic> row = {
      columnName: name,
      columnPrice: price,
    };
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteProduct(int id) async {
    Database db = await database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
