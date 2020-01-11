import 'dart:typed_data';
import 'package:my_game/services/Database.dart';
import 'package:sqflite/sqflite.dart';

import 'ConsoleProvider.dart';

class Game {

  int id;
  String name;
  DateTime releaseDate;
  Uint8List cover;
  Console console;

  Game();

  Game.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    name = map["name"];
    if (map["releaseDate"] != null) {
      releaseDate = DateTime.fromMillisecondsSinceEpoch(map["releaseDate"]);
    }
    cover = map["cover"];
    if (map["consoleId"] != null) {
      console = Console.fromMap({ "id": map["consoleId"], "name": map["consoleName"] });
    }
  }

  Map<String, dynamic> toMapToSaveOnDB() => {
    "id": id,
    "name": name,
    "releaseDate": releaseDate != null ? releaseDate.millisecondsSinceEpoch : null,
    "cover": cover,
    "consoleId": console?.id,
  };

  @override
  String toString() {
    return 'Game{id: $id, name: $name, releaseDate: $releaseDate, cover: $cover, console: $console}';
  }


}
class GameProvider {

  static const String tableName = "game";
  static const String table = '''
            CREATE TABLE IF NOT EXISTS $tableName(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT NOT NULL,
              releaseDate INT,
              cover BLOB,
              consoleId INTEGER,
              FOREIGN KEY(consoleId) REFERENCES console(id)
              ON DELETE SET NULL ON UPDATE NO ACTION
            );
        ''';

  CoreDatabase _coreDatabase = CoreDatabase();

  Future<List<Game>> loadGames() async {
    String sql = '''
      select $tableName.id, $tableName.name, $tableName.releaseDate,
      $tableName.cover, ${ConsoleProvider.tableName}.id as consoleId, ${ConsoleProvider.tableName}.name as consoleName
      from $tableName left join ${ConsoleProvider.tableName} on
      $tableName.consoleId = ${ConsoleProvider.tableName}.id
    ''';
    Database db = await _coreDatabase.database;
    List<Map<String, dynamic>> list = await db.rawQuery(sql);
    return list.map<Game>((map) => Game.fromMap(map)).toList();
  }

  Future<int> insert(Game game) async {
    Database db = await _coreDatabase.database;
    return db.insert(tableName, game.toMapToSaveOnDB());
  }

  Future<int> update(Game game) async {
    Database db = await _coreDatabase.database;
    return db.update(tableName, game.toMapToSaveOnDB(), where: "id = ?", whereArgs: [game.id]);
  }



}