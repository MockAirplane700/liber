import 'package:flutter/material.dart';
import 'package:liber/custom_objects/constants.dart';
import 'package:liber/custom_objects/interesting_website.dart';
import 'package:liber/logic/favourites_logic.dart';
import 'package:liber/logic/interesting_websites.dart';
import 'package:liber/logic/sql_persistence/database.dart';

import 'package:liber/widgets/bottom_navigation_bar.dart';
import 'package:liber/widgets/custom_navigation_drawer.dart';
import 'package:liber/widgets/search_delegate.dart';

import 'view_website_information.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  // final List<InterestingWebsite> interestingWebsites = InterestingWebsites.fetch();
  List<InterestingWebsite> interestingWebsites = FavouritesLogic.getWebsitesFromFavourites();

  @override
  void initState() {
    // TODO: implement initState
    //dialog box
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback( (_) async{
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('PLEASE TAKE NOTE!', style: TextStyle(color: textColor),),
          content: const Text(favouritesPageStringMessage, style: TextStyle(color: textColor),),
          actions: [
            TextButton(onPressed: () {
              Navigator.pop(context,'');
            }, child: const Text('Ok')),
          ],
        ),
        barrierDismissible: true,

      );
    });
  }//end init state

  @override
  Widget build(BuildContext context) {

    setState(() {});
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved websites', style: TextStyle(color: textColor),),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
              icon: const Icon(Icons.search)
          )
        ],
        iconTheme: const IconThemeData(color: applicationIconThemeColor),
        backgroundColor: appBarColor,
      ),
      backgroundColor: applicationBackgroundColor,
      bottomNavigationBar: const BottomNavBar(selectedIndex: 1,),
      drawer: const CustomDrawer(),
      body: Center(
        // make a list of cards with list tiles to show the website
        child: interestingWebsites.isNotEmpty ? ListView.builder(
          itemBuilder: (context, index) {
            return Card(child: ListTile(
              leading: Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.width/80), child: Image.network(interestingWebsites[index].networkImage),),
              title: Text('Name: ${interestingWebsites[index].name}'),
              subtitle: Text(interestingWebsites[index].description, overflow: TextOverflow.ellipsis,),
              trailing: IconButton(
                  onPressed: (){
                    FavouritesLogic.deleteFavouritesEntry(interestingWebsites[index]);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Website, ${interestingWebsites[index].name.toString()} has been deleted')));
                    setState(() {});
                  },
                  icon: const Icon(Icons.delete, color: Colors.red,)
              ),
              onTap: () {
                //go to view website
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewWebsiteInfo(interestingWebsite: interestingWebsites[index])));
              },
            ),);
          },
          itemCount: interestingWebsites.length,
        ) : const Text('There are currently no saved websites'),

      ),
    );
  }
}
