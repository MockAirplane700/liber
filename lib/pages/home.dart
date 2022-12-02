import 'package:flutter/material.dart';
import 'package:liber/custom_objects/constant_functions.dart';
import 'package:liber/custom_objects/constants.dart';
import 'package:liber/custom_objects/interesting_website.dart';
import 'package:liber/logic/ad_helper.dart';
import 'package:liber/logic/interesting_websites.dart';
import 'package:liber/pages/view_website_information.dart';
import 'package:liber/widgets/bottom_navigation_bar.dart';
import 'package:liber/widgets/custom_navigation_drawer.dart';
import 'package:liber/widgets/search_delegate.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();

// Future<InitializationStatus> _initGoogleMobileAds() {
//   //todo: initialize google mobile ads
//   return MobileAds.instance.initialize();
// }//end method
}

class _HomeState extends State<Home> {
  final List<InterestingWebsite> interestingWebsites = InterestingWebsites.fetch();
  List<InterestingWebsite> searchList = [];
  //TODO: add _kAdIndex
  static final _kAdIndex = 4;

  // TODO: add a banner ad instance
  //  BannerAd ? _ad;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // TODO: Load a banner ad
    //  BannerAd(
    //    adUnitId: AdHelper.bannerAdUnitId,
    //    size: AdSize.banner,
    //    request: const AdRequest(),
    //    listener: BannerAdListener(
    //      onAdLoaded: (ad) {
    //        setState(() {
    //          _ad = ad as BannerAd;
    //        });
    //      },
    //      onAdFailedToLoad: (ad, error) {
    //        // releases an ad resource when it fails to load
    //        ad.dispose();
    //        throw Exception('Ad load failed (code=${error.code} message=${error.message}');
    //      }
    //    ),
    //  ).load();
  }// end init state

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // set constant functions list to zero
    ConstantFunctions.setToZero();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interesting websites', style: TextStyle(color: textColor),),
        elevation: 0,
        iconTheme: const IconThemeData(color: applicationIconThemeColor),
        backgroundColor: appBarColor,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
              icon: const Icon(Icons.search)
          )
        ],
      ),
      // todo add Drawer( profilePicture: networkStringImage)
      drawer:const CustomDrawer(),
      backgroundColor: applicationBackgroundColor,
      body: Center(
        // make a list of cards with list tiles to show the website
        child: FutureBuilder(
            builder: (context , snapshot) {
              if (snapshot.hasData)  {
                List websites = snapshot.data as List;
                //check for error before viewing
                if (websites.isEmpty) {
                  return const Text('No websites are available');
                }else{
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      InterestingWebsite website = InterestingWebsite(
                        networkImage: websites[index]['networkImage'], name: websites[index]['name'],
                        description: websites[index]['description'],
                        datePublished: websites[index]['datePublished'], source: websites[index]['source'],
                        websiteUrl: websites[index]['websiteUrl'],
                        id: websites[index]['_id'].hashCode,
                      );
                      //add the resulting website to the search list
                      ConstantFunctions.addToList(website);
                      return Card(child: ListTile(
                        leading: Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.width/80),
                          child: SizedBox(width: width/6,child: Image.network(websites[index]['networkImage'], fit: BoxFit.contain,)),),
                        title: Text('Name: ${websites[index]['name']}'),
                        subtitle: Text(websites[index]['description'], overflow: TextOverflow.ellipsis,),
                        trailing: const Icon(Icons.drag_indicator),
                        onTap: () {
                          //go to view website
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewWebsiteInfo(interestingWebsite: website)));
                        },
                      ),);
                      // TODO: Render a banner ad
                      // if (_ad != null && index == _kAdIndex){
                      //   return Container(
                      //     width: _ad!.size.width.toDouble(),
                      //     height: MediaQuery.of(context).size.height/50,
                      //   );
                      // }else{
                      //
                      // }//end if-else
                    },
                    itemCount: websites.length,
                  );
                }
              }else{
                return const Center(child: CircularProgressIndicator(),);
              }
            },
          future: InterestingWebsites.getWebsites(),
        ),
      ),
    );
  }
}
