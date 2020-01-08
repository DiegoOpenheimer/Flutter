import 'dart:typed_data';
import 'package:my_game/services/Database.dart';
import 'package:sqflite/sqflite.dart';

class Game {

  int id;
  String name;
  DateTime releaseDate;
  Uint8List cover;

}

class GameProvider {

  CoreDatabase _coreDatabase = CoreDatabase();

  void loadGames() async {
    // TODO implements load games
   // Database db = await _coreDatabase.database;
  }

}