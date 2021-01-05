import 'dart:async';
import 'dart:io';

import 'package:rent_calculator_app/models/monthRent.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableRent = "rentTable";
  final String columnId = "id";
  final String monthName = "monthName";
  final String totalMonthPrice = "totalMonthPrice";
  final String totalUnitValue = "totalUnitValue";
  final String perTotalUnitValue = "perTotalUnitValue";
  final String wasteValue = "wasteValue";
  final String waterValue = "waterValue";
  final String totalAmount = "totalAmount";

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(
        documentDirectory.path, "maindb.db"); //home://directory/files/maindb.db

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  /*
     id | monthName | totalMonthPrice
     ------------------------
     1  | Baisakh    | 14526
     2  | Jestha    | 15265
   */

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tableRent($columnId INTEGER PRIMARY KEY, $monthName TEXT, $totalMonthPrice TEXT, $totalUnitValue TEXT, $perTotalUnitValue TEXT, $wasteValue TEXT, $waterValue TEXT, $totalAmount TEXT)");
  }

  //CRUD - CREATE, READ, UPDATE , DELETE

  //Insertion
  Future<int> saveRentData(MonthData user) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tableRent", user.toMap());
    return res;
  }

  //Get Users
  Future<List> getAllRentData() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableRent");

    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $tableRent"));
  }

  Future<MonthData> getMonth(int id) async {
    var dbClient = await db;

    var result = await dbClient
        .rawQuery("SELECT * FROM $tableRent WHERE $columnId = $id");
    if (result.length == 0) return null;
    return new MonthData.fromMap(result.first);
  }

  Future<int> deleteRentMonth(int id) async {
    var dbClient = await db;

    return await dbClient
        .delete(tableRent, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> updateRentMonth(MonthData user) async {
    var dbClient = await db;
    return await dbClient.update(tableRent, user.toMap(),
        where: "$columnId = ?", whereArgs: [user.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
