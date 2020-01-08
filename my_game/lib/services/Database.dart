import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CoreDatabase {

  static CoreDatabase _instance = CoreDatabase._internal();

  CoreDatabase._internal();

  factory CoreDatabase() => _instance;

  Future<Database> get database async {
    String path = join(await getDatabasesPath(), 'my_game.db');
    return await openDatabase(path, version: 1,
      onConfigure: (db) => db.execute('PRAGMA foreign_keys = ON'),
      onCreate: (Database db, int version) async {
        await db.execute('''
            CREATE TABLE IF NOT EXISTS console (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT
            );
        ''');

        await db.execute('''
            CREATE TABLE IF NOT EXISTS game(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT NOT NULL,
              releaseDate INT,
              cover BLOB,
              consoleId INTEGER,
              FOREIGN KEY(consoleId) REFERENCES console(id)
              ON DELETE SET NULL ON UPDATE NO ACTION
            );
        ''');
      }
    );
  }

}