

import 'package:my_game/services/Database.dart';
import 'package:sqflite/sqflite.dart';

class Console {

  int id;
  String name;

  Console({ this.name });

  Console.fromMap(Map map) {
    id = map["id"];
    name = map["name"];
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
  };

  @override
  String toString() {
    return 'Console{id: $id, name: $name}';
  }

}

class ConsoleProvider {

  CoreDatabase _coreDatabase = CoreDatabase();

  static const String tableName = "console";
  static const String table = '''
            CREATE TABLE IF NOT EXISTS $tableName (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT
            );
        ''';

  Future<List<Console>> loadConsoles() async {
    Database db = await _coreDatabase.database;
    return (await db.query(tableName))
        .map<Console>((map) => Console.fromMap(map)).toList();
  }

  Future<Console> insert(String name) async {
    Database db = await _coreDatabase.database;
    Console console = Console(name: name);
    console.id = await db.insert(tableName, console.toMap());
    return console;
  }

  Future<int> delete(Console console) async {
    Database db = await _coreDatabase.database;
    return db.delete(tableName, where: "id = ?", whereArgs: [console.id]);
  }

}