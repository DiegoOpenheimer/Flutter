

import 'package:flutter_todo/model/Task.dart';
import 'package:flutter_todo/services/Database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDAO {

  static String tableName = 'task';

  DatabaseSQFlite _databaseSQFlite = DatabaseSQFlite();


  Future<List<Task>> getTasks() async {
    Database db = await _databaseSQFlite.open();
    List<Map> maps = await db.query(tableName, );
    db.close();
    return maps.map<Task>((map) => Task.fromMap(map)).toList();
  }

  Future<int> insert(Task task) async {
    Database db = await _databaseSQFlite.open();
    int id = await db.insert(tableName, task.toMap());
    db.close();
    return id;
  }
  
  Future remove(Task task) async {
    Database db = await _databaseSQFlite.open();
    int id = await db.delete(tableName, where: 'id = ?', whereArgs: [task.id]);
    db.close();
    return id;
  }

  Future update(Task task) async {
    Database db = await _databaseSQFlite.open();
    int id = await db.update(tableName, task.toMap(), where: 'id = ?', whereArgs: [task.id]);
    db.close();
    return id;
  }


}