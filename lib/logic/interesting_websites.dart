import 'package:liber/custom_objects/interesting_website.dart';
import 'package:liber/persistence/mongo_database.dart';
import 'package:mongo_dart/mongo_dart.dart';

class InterestingWebsites {

  static final List<InterestingWebsite> interestingWebsites = [
    InterestingWebsite(
        networkImage: 'https://cdn.freeriderhd.com/free_rider_hd/sprites/frhd_1200x1200_v2.png',
        name: 'Free rider ',
        description: 'lorem ipsum',
        datePublished: '26 March 2013',
        source: 'https://www.tiktok.com/@setupspawn/video/7125453778920279342?is_copy_url=1&is_from_webapp=v1',
        websiteUrl: 'https://www.freeriderhd.com/create',
      id: 0.toString()
    ),
    InterestingWebsite(
        networkImage: 'https://cdn.freeriderhd.com/free_rider_hd/sprites/frhd_1200x1200_v2.png', name: 'Free rider ',
        description: 'lorem ipsum', datePublished: '26 March 2013',
        source: 'https://www.tiktok.com/@setupspawn/video/7125453778920279342?is_copy_url=1&is_from_webapp=v1',
        websiteUrl: 'https://www.freeriderhd.com/create',
        id: 0.toString()
    ),
    InterestingWebsite(
        networkImage: 'https://cdn.freeriderhd.com/free_rider_hd/sprites/frhd_1200x1200_v2.png', name: 'Free rider ',
        description: 'lorem ipsum', datePublished: '26 March 2013',
        source: 'https://www.tiktok.com/@setupspawn/video/7125453778920279342?is_copy_url=1&is_from_webapp=v1',
        websiteUrl: 'https://www.freeriderhd.com/create',
        id: 0.toString()
    ),
    InterestingWebsite(
        networkImage: 'https://cdn.freeriderhd.com/free_rider_hd/sprites/frhd_1200x1200_v2.png', name: 'Free rider ',
        description: 'lorem ipsum', datePublished: '26 March 2013',
        source: 'https://www.tiktok.com/@setupspawn/video/7125453778920279342?is_copy_url=1&is_from_webapp=v1',
        websiteUrl: 'https://www.freeriderhd.com/create',
        id: 0.toString()
    ),
    InterestingWebsite(
        networkImage: 'https://cdn.freeriderhd.com/free_rider_hd/sprites/frhd_1200x1200_v2.png', name: 'Free rider ',
        description: 'lorem ipsum', datePublished: '26 March 2013',
        source: 'https://www.tiktok.com/@setupspawn/video/7125453778920279342?is_copy_url=1&is_from_webapp=v1',
        websiteUrl: 'https://www.freeriderhd.com/create',
        id:0.toString()
    ),
  ];

  static List<InterestingWebsite> fetch() {
    return interestingWebsites;
  }

  static Future getWebsites() async {
    return MongoDatabase.getDocuments();
  }
}