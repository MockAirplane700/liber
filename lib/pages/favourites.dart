import 'package:flutter/material.dart';
import 'package:liber/custom_objects/constants.dart';
import 'package:liber/custom_objects/interesting_website.dart';
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
  List<InterestingWebsite> interestingWebsites = [];

  @override
  Widget build(BuildContext context) {

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
        child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                interestingWebsites = snapshot.data as List<InterestingWebsite>;
                if (interestingWebsites.isEmpty) {
                  return const Text('No websites are currently saved');
                }else{
                  //core widget display
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(child: ListTile(
                        leading: Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.width/80), child: Image.network(interestingWebsites[index].networkImage),),
                        title: Text('Name: ${interestingWebsites[index].name}'),
                        subtitle: Text(interestingWebsites[index].description, overflow: TextOverflow.ellipsis,),
                        trailing: IconButton(
                            onPressed: () async{
                              await DatabaseManager.deleteWebsite(interestingWebsites[index]).whenComplete(() {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Website, ${interestingWebsites[index].name.toString()} has been deleted')));
                              });
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
                  );
                }
              }else{
                //no data
                return const CircularProgressIndicator();
              }//end if-else
            },
          future: DatabaseManager.getWebsites(),
        ),

      ),
    );
  }
}
