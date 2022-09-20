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
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0,),
      body: Center(
        // make a list of cards with list tiles to show the website
        child: FutureBuilder(
            builder: (context , snapshot) {
              if (snapshot.hasData)  {
                List websites = snapshot.data as List<Map<String,dynamic>>;
                //check for error before viewing
                if (websites.isEmpty) {
                  return const Text('No websites are available');
                }else{
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      InterestingWebsite website = InterestingWebsite(
                        networkImage: '', name: '', description: '',
                        datePublished: '', source: '', websiteUrl: '',
                        id: 0.toString(),
                      );
                      InterestingWebsite resultingWebsite =  website.fromJson(websites[index]);
                      //add the resulting website to the search list
                      ConstantFunctions.addToList(resultingWebsite);
                      return Card(child: ListTile(
                        leading: Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.width/80), child: Image.network(resultingWebsite.networkImage),),
                        title: Text('Name: ${resultingWebsite.name}'),
                        subtitle: Text(resultingWebsite.description, overflow: TextOverflow.ellipsis,),
                        trailing: const Icon(Icons.drag_indicator),
                        onTap: () {
                          //go to view website
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewWebsiteInfo(interestingWebsite: resultingWebsite)));
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
