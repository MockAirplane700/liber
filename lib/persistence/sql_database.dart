import 'package:liber/custom_objects/interesting_website.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLDatabase {
  static late Database _database;

  // final String id;
  // final String name;
  // final String datePublished;
  // late final String description;
  // final String networkImage;
  // final String websiteUrl;
  // final String source;

  static Future openDb() async {
    _database = await openDatabase(
        join(await getDatabasesPath(), "savedWebsites.ddb"),
        version: 1,
        onCreate: (Database db, int version) async{
          await db.execute(
              "CREATE TABLE websites(websiteId INTEGER PRIMARY KEY autoincrement, name TEXT, datePublished TEXT, networkImage TEXT, description TEXT, websiteUrl TEXT, source TEXT) "
          );
        }
    );
    return _database;
  }//end open db

  static Future insertStore(InterestingWebsite website) async{
    await openDb();
    try {
      return await _database.insert('websites', website.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    }catch (error) {
      throw Exception(error.toString());
    }//end try-catch
  }//end insert store

  static Future<List<InterestingWebsite>> getWebsites() async {
    await openDb();
    final List<Map<String,dynamic>> maps = await _database.query('websites');

    return List.generate(maps.length, (index) {
      return InterestingWebsite(
          networkImage: maps[index]['networkImage'], name: maps[index]['name'],
          description: maps[index]['description'], datePublished: maps[index]['datePublished'],
          source: maps[index]['source'], websiteUrl: maps[index]['websiteUrl'], id: maps[index]['websiteId']
      );
    }).toList();
  }//end get websites

  static Future<void> deleteStore(InterestingWebsite website) async {
    await openDb();
    await _database.delete('websites', where: "websiteId = ?" , whereArgs: [website.id]);
  }//end delete store

  static Future<int> updateStore(InterestingWebsite website) async {
    await openDb();
    return await _database.update('websites', website.toJson(), where: "websiteId = ?", whereArgs: [website.id]);
  }//end update store

}//end class