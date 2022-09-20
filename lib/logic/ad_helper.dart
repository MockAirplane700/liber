import 'dart:io';

import 'package:liber/custom_objects/constants.dart';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return addMobTestBannerAndroid;
    } else  if (Platform.isIOS){
      return addMobTestBannerIos;
    }else{
      throw UnsupportedError('Unsupported platform');
    }//end if-else
  }//end banner ad unit id

  static String get nativeAdUnit{
    if (Platform.isAndroid) {
      return addMobTestNativeAndroid;
    } else  if (Platform.isIOS){
      return addMobTestNativeIos;
    }else{
      throw UnsupportedError('Unsupported platform');
    }//end if-else
  }//end get native ad unit
}//end ad helper