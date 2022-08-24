import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static DbCollection collection = DbCollection(Db('interestingWebsites'), 'websites');
 static Db database = Db('interestingWebsites');

  static connect() async {
    database = await Db.create('mongodb+srv://TestUser:Test%40123@cluster0.vwx6rwi.mongodb.net/interestingWebsites');
    await database.open();
    collection =  database.collection('websites');
  }//end connect

  static Future<List<Map<String,dynamic>>> getDocuments() async {
    try {
      final websites = await collection.find().toList();
      return websites;
    } catch (error) {
      //returns error in map
      Future<List<Map<String, dynamic>>> result = [
       {
         'Error' : error.toString()
       },
      ] as Future<List<Map<String, dynamic>>>;
      return  result;
    }//end try-catch
  }//end get Documents
}//end Mongo database