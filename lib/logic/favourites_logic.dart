import 'package:liber/custom_objects/interesting_website.dart';
import 'package:liber/persistence/csv_database.dart';

class FavouritesLogic {
  static List<InterestingWebsite> websites = [];

  static void initiateFavouritesDatabase() {
    CsvManager.generateCsv();
  }//end init

  static  getFavourites() async{
    websites = await CsvManager.readCsv();
  }//end get favourites

  static List<InterestingWebsite> getWebsitesFromFavourites() {
    getFavourites();
    return websites;
  }//end get websites from favourites

  static List<String> convertToCsv(InterestingWebsite website) {
    // ['id', 'name', 'datePublished', 'description', 'networkImage', 'websiteUrl', 'source'],
    return [
      (website.id.toString()), (website.name.toString()), (website.datePublished.toString()),
      (website.description.toString()), (website.networkImage.toString()), (website.websiteUrl.toString()),
      (website.source.toString())
    ];
  }//end convert to csv

  static void addToFavourites(InterestingWebsite websiteCsvEntry) {
    CsvManager.addInterestingWebsites(convertToCsv(websiteCsvEntry));
  }//end add to favourites

  static void deleteFavouritesEntry(InterestingWebsite website) {
    List<InterestingWebsite> temp = CsvManager.deleteWebsite(websites, website);
    websites = temp.toList();
  }//end delete favourite entry

}//end favourites logic