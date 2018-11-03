import 'dart:async';
import 'package:contact/Model/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String contactTable = 'contactTable';
final String idColumn = 'idColumn';
final String nameColumn = 'nameColumn';
final String emailColumn = 'emailColumn';
final String phoneColumn = 'phoneColumn';
final String imageColumn = 'imageColumn';


class ContactHelper {

  static final ContactHelper _instance = ContactHelper.internal();
  Database _db;

  ContactHelper.internal();

  factory ContactHelper() => _instance;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath + 'contacts.db');
    return await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT, $phoneColumn TEXT, $imageColumn TEXT)");
    });
  }

  Future<int> insert(Contact contact) async {
    Database database = await db;
    return await database.insert(contactTable, contact.toMap());
  }

  Future<Contact> getById(int id) async {
      Database database = await db;
      List<Map> maps = await database.query(contactTable,
        columns: [idColumn, nameColumn, emailColumn, phoneColumn, imageColumn],
        where: "$idColumn = ?",
        whereArgs: [id]
      );
      if ( maps.length > 0 ) {
        return Contact.fromMap(maps.first);
      }
      return null;
  }

  Future<List<Contact>> getContacts() async {
    Database database = await db;
    List maps = await database.rawQuery("SELECT * FROM $contactTable");
    List<Contact> contacts = List.generate(maps.length, (int index) => Contact.fromMap( maps[index] ));
    return contacts;
  }

  Future<int> update(Contact contact) async {
      Database database = await db;
      return await database.update(contactTable, contact.toMap(), where: "$idColumn = ?", whereArgs: [contact.id]);
  }

  Future<int> delete(int id) async {
      Database database = await db;
      return await database.delete(contactTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> getAmount() async {
    Database database = await db;
    return Sqflite.firstIntValue(await database.rawQuery("SELECT COUNT(*) FROM $contactTable"));
  }

  Future close() async {
    Database database = await db;
    return database.close();
  }

}