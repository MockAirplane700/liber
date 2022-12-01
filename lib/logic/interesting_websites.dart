import 'package:liber/custom_objects/interesting_website.dart';
import 'package:liber/persistence/mongo_database.dart';
import 'package:mongo_dart/mongo_dart.dart';

class InterestingWebsites {

  static final List<InterestingWebsite> interestingWebsites = [
  ];

  static List<InterestingWebsite> fetch(){
    return interestingWebsites;
  }

  static Future getWebsites() async {
    return MongoDatabase.getDocuments();
  }
}