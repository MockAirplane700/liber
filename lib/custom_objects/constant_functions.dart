import 'package:liber/custom_objects/interesting_website.dart';
import 'package:liber/logic/interesting_websites.dart';
import 'package:url_launcher/url_launcher.dart';

class ConstantFunctions {

  static String profilePictureNetworkString = '';
  static Function signOutAction = null as Function;
  static List interestingWebsites = [];


  static Future<void> launchUrlFromLogic(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  static void addNetworkString(String string) {
    profilePictureNetworkString = string;
  }//end network string

  static String getProfilePicture() {
    return profilePictureNetworkString;
  }//end get profile string

  static void setSignOutAction(Function() action){
    signOutAction = action;
  }//end set sign out action

  static void signOut() {
    signOutAction;
  }//end sign out

  static temp() async {
    // List websites = snapshot.data as List<Map<String,dynamic>>;
    interestingWebsites = await InterestingWebsites.getWebsites() as List<Map<String,dynamic>>;
}//end temp

  static List populateSearchDelegate() {
    return interestingWebsites;
  }//end populate search delegate

  static void addToList(InterestingWebsite websites) {
    interestingWebsites.add(websites);
  }//end add to list
}