import 'package:flutter_todo/model/TaskDAO.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseSQFlite {

  static DatabaseSQFlite _instance = DatabaseSQFlite._internal();

  DatabaseSQFlite._internal();

  factory DatabaseSQFlite() => _instance;

  Future<Database> open() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'task.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS ${TaskDAO.tableName} (
            id integer primary key autoincrement,
            name text not null,
            complete integer
          )
        ''');
      }
    );
  }

}