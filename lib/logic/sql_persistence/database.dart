import 'package:liber/custom_objects/interesting_website.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  static late Database _database;

  static Future openDb() async {

    _database = await openDatabase(
      join(await getDatabasesPath(), "savedWebsites.ddb"),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE interestingWebsites(id INTEGER PRIMARY KEY, name TEXT, networkImage TEXT,"
              "description TEXT, datePublished TEXT, source TEXT, websiteUrl TEXT)"
        );
      }
    );
    return _database;
  }//end open db

  static Future insertWebsite(InterestingWebsite website) async {
    await openDb();
    return await _database.insert('interestingWebsites', website.toJson());
  }//end insert website

  static Future<List<InterestingWebsite>> getWebsites() async {
    await openDb();
    final List<Map<String,dynamic>> maps = await _database.query('interestingWebsites');

    return List.generate(maps.length, (index) {
      return InterestingWebsite(
          networkImage: maps[index]['networkImage'], name: maps[index]['name'],
          description: maps[index]['description'], datePublished: maps[index]['datePublished'],
          source: maps[index]['source'], websiteUrl: maps[index]['websiteUrl'], id: maps[index]['id']
      );
    }).toList();
  }//end get websites

  static Future<void> deleteWebsite(InterestingWebsite website) async {
    await openDb();
    await _database.delete(
      'interestingWebsites',where: "id = ?", whereArgs: [website.id]
    );
  }//end delete website

  static Future<int> updateWebsite(InterestingWebsite website) async {
    await openDb();
    return await _database.update('interestingWebsites', website.toJson(), where: "id = ?", whereArgs: [website.id]);
  }// end update website


}//end database manager