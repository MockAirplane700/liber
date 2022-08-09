import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlTest {
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
        return db.execute(
          'CREATE TABLE websites(id INTEGER PRIMARY KEY, name TEXT,age INTEGER) '
        );
      },
      //Set the version, this executes the onCreate function and provides the path to
      //perform database upgrades and downgrades
      version: 1
    );
  }

  Future<void> insertWebsite(Website website) async {
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
  Future<List<Website>> websites() async {
    //get a reference to the database
    final db  = await database;

    //Query the table for all the dogs
    final List<Map<String,dynamic>> maps = await db.query('websites');

    //Convert the List<Map<String, dynamic>> into List<Website>
    return List.generate(maps.length, (index) {
      return Website(
          name: maps[index]['name'],
          age: maps[index]['age'],
          id: maps[index]['id']
      );
    });
  }//end websites

  Future<void> updateWebsite(Website website) async{
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

}// end class


class Website {
  final int id;
  final String name;
  final int age;

  const Website({
    required this.name, required this.age, required this.id
});

  //Convert a website into a Map, the keys must correspond with names of the columns in the database
  Map<String,dynamic> toMap() {
    return {
      'id':id,
      'name': name,
      'age':age
    };
  }

  @override
  String toString() {
    return 'Website{id: $id, name: $name, age: $age}';
  }//end to string
}//end Website

