import 'package:url_launcher/url_launcher.dart';

class ConstantFunctions {
  static Future<void> launchUrlFromLogic(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }


}