import 'package:liber/custom_objects/interesting_website.dart';
import 'package:liber/persistence/sql_database.dart';

class FavouritesLogic {
  static List<InterestingWebsite> websites = [];
  static List<InterestingWebsite> websiteList = [];

  ///*************************************************************************************************
  ///
  ///           SQL BASED LOGIC
  ///
  /// **************************************************************************************************


  static getFavouritesSQL() async {
    return await SQLDatabase.getWebsites();
  }

  static void addNewWebsiteToFavourite (InterestingWebsite website) {
    SQLDatabase.insertStore(website);
  }//end add new website to favorite

  static void deleteWebsiteFromList(InterestingWebsite website) {
    SQLDatabase.deleteStore(website);
  }//end delete website

}//end favourites logic