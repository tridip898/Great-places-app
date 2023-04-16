import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:flutter/foundation.dart';

// class DBHelper {
//   static Future<void> insertData(String table, Map<String, Object> data) async {
//     final dbPath = await sql.getDatabasesPath();
//     final sqlDb = await sql.openDatabase(path.join(dbPath, 'places.db'),
//         onCreate: (db, version) async {
//       await db.execute("""CREATE TABLE user_places(
//       id TEXT PRIMARY KEY,
//       title TEXT,
//       image TEXT""");
//       }, version: 1);
//     await sqlDb.insert(table, data,conflictAlgorithm: sql.ConflictAlgorithm.replace);
//   }
// }

class SQLHelper {
  //this method is for create tables
  static Future<void> createTables(sql.Database database) async {
    //here we create table and table name is items
    await database.execute("""CREATE TABLE user_places(
    id TEXT PRIMARY KEY,
    title TEXT,
    image TEXT,
    """);
  }

  //this method called create table function and we set database name and its version number
  static Future<sql.Database> db() async {
    return sql.openDatabase('places.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  //this method is for insert data in database
  static Future<void> createItems(Map<String, Object> data) async {
    //this is for get database connection
    final db = await SQLHelper.db();

    //final data = {'title': title, 'description': description};
    //db.insert for insert data in database
    final id = await db.insert('user_places', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    //its return one row of data from database based on id
    //return id;
  }

  //this method is for retrieve data from our database. query is used for getting data from database
  static Future<List<Map<String,dynamic>>> getItems() async {
    //this is for get database connection
    final db = await SQLHelper.db();
    //db.query is for get one or all or specific data from database
    return db.query('user_places');
  }

  //this method is for retrieve only one data from our database based on id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    //this is for get database connection
    final db = await SQLHelper.db();
    //here we pass arguments for certain data and set limit 1 for only one data
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  //this method is for update our table data in database. here we can update title and description of specific id
  static Future<int> updateItems(
      int id, String title, String description) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title,
      'description': description,
      'createdAt': DateTime.now().toString()
    };
    final result =
        await db.update('items', data, where: "id= ?", whereArgs: [id]);
    return result;
  }

  //this method is used from delete data from database. it delete data for specific id
  static Future<void> deleteItems(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('items', where: "id= ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item $err");
    }
  }
}
