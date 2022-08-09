import 'package:liber/custom_objects/interesting_website.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:ui';

class Websites {
  var database;

  Future<void> implementDatabase() async {
    database = openDatabase(
      //Set the path to the database. Note: Using the join function from the path package is
      //best practice to ensure the path is correctly constructed for each platform
        join(await getDatabasesPath(), 'websites_database.db'),
        //When the database is first created, create a table to store the websites
        onCreate: (db,version) {
          //Run the create table statement on the database
          // todo: check if the database is already there
          ///=========
          ///'id':id,
          //       'name': name,
          //       'published':datePublished,
          //       'description':description,
          //       'networkImage':networkImage,
          //       'websiteUrl':websiteUrl,
          //       'source':source
          ///==================
          return db.execute(
              'CREATE TABLE websites(id INTEGER PRIMARY KEY, name TEXT, published TEXT, description TEXT, networkImage TEXT, websiteUrl TEXT, source TEXT) '
          );
        },
        //Set the version, this executes the onCreate function and provides the path to
        //perform database upgrades and downgrades
        version: 1
    );
  }

  Future<void> insertWebsite(InterestingWebsite website) async {
    //get a reference to the database
    final db = await database;

    //insert the website into the correct table. We might also specify the conflict algorithm to use
    // in the case the same website is inserted twice
    await db.insert(
        'websites',
        website.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }//end insert website

  // A method that retrieves all the dogs from the dogs table.

  Future<List<InterestingWebsite>> websites() async {
    //get a reference to the database
    final db  = await database;

    //Query the table for all the dogs
    final List<Map<String,dynamic>> maps = await db.query('websites');

    //Convert the List<Map<String, dynamic>> into List<Website>
    return List.generate(maps.length, (index) {
      return InterestingWebsite(
          name: maps[index]['name'],
          id: maps[index]['id'],
        websiteUrl: maps[index]['websiteUrl'],
        networkImage: maps[index]['networkImage'],
        datePublished: maps[index]['datePublished'],
        description: maps[index]['description'],
        source: maps[index]['source']
      );
    });
  }//end websites

  Future<void> updateWebsite(InterestingWebsite website) async{
    //reference to the database
    final db = await database;

    //update the given website
    await db.update(
        'websites',
        website.toMap(),
        //Ensure the website has a matching id
        where: 'id = ?',
        // Pass the website id as where ag to prevent SQL injection
        whereArgs: [website.id]
    );
  }//end method

  Future<void> deleteWebsite(int id) async {
    //get a reference to the database
    final db = await database;

    // remove the website from the database
    await db.delete(
        'websites',
        // use a where clause to delete a specific website
        where: 'id =?',
        whereArgs: [id]
    );
  }//end method


}

void main() async {
  Websites websites = Websites();
  websites.implementDatabase();
  websites.insertWebsite(InterestingWebsite(
      networkImage: 'https://cdn.freeriderhd.com/free_rider_hd/sprites/frhd_1200x1200_v2.png', name: 'Free rider ',
      description: 'lorem ipsum', datePublished: '26 March 2013',
      source: 'https://www.tiktok.com/@setupspawn/video/7125453778920279342?is_copy_url=1&is_from_webapp=v1',
      websiteUrl: 'https://www.freeriderhd.com/create',
      id: 3
  ));
  var list = [];
  websites.websites().then((value) {
    list = value.toList();
  });
  print('SQL database: \n: ${list.first.toString()}');
}