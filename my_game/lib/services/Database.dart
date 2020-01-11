import 'package:my_game/model/ConsoleProvider.dart';
import 'package:my_game/model/GameProvider.dart';
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
        await db.execute(GameProvider.table);
        await db.execute(ConsoleProvider.table);
      }
    );
  }

}