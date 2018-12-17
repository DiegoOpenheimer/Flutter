import 'package:organizze_flutter/Model/Place.dart';
import 'package:organizze_flutter/Model/Trip.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


const String createTableTrip = '''
          create table if not exists Trip (
            id integer primary key autoincrement,
            name text,
            img text,
            price real
            );                      
         ''';
const String createTablePlace = '''
            create table if not exists Place (
            id integer primary key autoincrement,
            name text,
            description text,
            price real,
            latitude real,
            longitude real,
            trip_id integer,
             FOREIGN KEY (Trip_id)
              REFERENCES Trip (id)
              ON DELETE CASCADE
              ON UPDATE CASCADE);
''';

const String tableTrip = 'Trip';
const String tablePlace = 'Place';

class TripRepository {

  static final TripRepository _instance = TripRepository.internal();

  TripRepository.internal();

  factory TripRepository() => _instance;

  Database db;

  Future open() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'trip.db');
    db = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
        try {
          await db.execute(createTableTrip);
          await db.execute(createTablePlace);
        } catch (e) {
          print(e);
        }
    });
  }

  Future<int> insertTrip(Trip trip) async {
    try {
      return await db.insert(tableTrip, trip.toMap());
    } on Exception catch( e ) {
      throw e;
    }
  }

  Future<List<Trip>> getTrips() async {
    try {
      List<Map<String, dynamic>> maps = await db.query(tableTrip,
        columns: ['*']);
      List<Map<String, dynamic>> mapsPlace = await db.query(tablePlace, columns: ['*']);
      return maps.map((Map<String, dynamic> map) => Trip.fromMap(map)..places =
          mapsPlace.map((p) => Place.fromMap(p)).where((Place place) => place.idTrip == map['id']).toList()
      ).toList();
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<int> savePlace(Place place) async {
    return await db.insert(tablePlace, place.toMap());
  }

  Future<int> updateTrip(Trip trip) async {
    return await db.update(tableTrip, trip.toMap(), where: "id = ?", whereArgs: [trip.id]);
  }

  Future<int> removeTrip(int id) async {
    db.delete(tablePlace, where: "trip_id = ?", whereArgs: [id]);
    return await db.delete(tableTrip, where: "id = ?", whereArgs: [id]);
  }

}