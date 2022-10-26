import 'package:liber/custom_objects/constants.dart';
import 'package:liber/custom_objects/interesting_website.dart';
import 'package:liber/custom_objects/tiktoker.dart';
import 'package:liber/logic/interesting_websites.dart';
import 'package:url_launcher/url_launcher.dart';

class ConstantFunctions {

  static String profilePictureNetworkString = 'https://firebasestorage.googleapis.com/v0/b/coupons-are-us.appspot.com/o/Liber%20logo.png?alt=media&token=4965c137-e0da-41cd-b985-3835fa214116';
  static Function ?signOutAction;
  static List interestingWebsites = [];


  static Future<void> launchUrlFromLogic(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  static void addNetworkString(String string) {
    profilePictureNetworkString = string;
  }//end network string

  static List<TikToker> getTikTokers() {
    List<TikToker> tokers = [];
    for (var value in listOfTikTokAccounts) {
      tokers.add(TikToker(name: value[0], networkImage: value[1], link: value[3], description: value[2]));
    }//end list
    return tokers;
  }//end get tikTokers
  static String getProfilePicture() {
    return profilePictureNetworkString;
  }//end get profile string

  static void setSignOutAction(Function() action){
    signOutAction = action;
  }//end set sign out action

  static void signOut() {
    signOutAction;
  }//end sign out

  static void setLogoutAction(Function function) {
    signOutAction = function;
  }//end set out log out action

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

  static void setToZero() {
    interestingWebsites.clear();
  }//end set to zero
}