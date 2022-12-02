import 'package:flutter/material.dart';
import 'package:liber/custom_objects/constants.dart';
import 'package:liber/custom_objects/interesting_website.dart';
import 'package:liber/logic/favourites_logic.dart';
import 'package:liber/logic/interesting_websites.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    //dialog box
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback( (_) async{
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) => AlertDialog(
    //       title: const Text('PLEASE TAKE NOTE!', style: TextStyle(color: textColor),),
    //       content: const Text(favouritesPageStringMessage, style: TextStyle(color: textColor),),
    //       actions: [
    //         TextButton(onPressed: () {
    //           Navigator.pop(context,'');
    //         }, child: const Text('Ok')),
    //       ],
    //     ),
    //     barrierDismissible: true,
    //
    //   );
    // });
  }//end init state

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
      drawer: const CustomDrawer(),
      body: Center(
        // make a list of cards with list tiles to show the website
        child: FutureBuilder(
            builder: (context, snapshot){
              if (snapshot.hasData) {
                List list = snapshot.data as List;
                return list.isNotEmpty ? ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(child: ListTile(
                      leading: Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.width/80),
                        child: SizedBox(width: width/6,child: Image.network(list[index].networkImage)),),
                      title: Text('Name: ${list[index].name}'),
                      subtitle: Text(list[index].description, overflow: TextOverflow.ellipsis,),
                      trailing: IconButton(
                          onPressed: (){
                            FavouritesLogic.deleteWebsiteFromList(list[index]);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Website, ${list[index].name.toString()} has been deleted')));
                            setState(() {});
                          },
                          icon: const Icon(Icons.delete, color: Colors.red,)
                      ),
                      onTap: () {
                        //go to view website
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewWebsiteInfo(interestingWebsite: list[index])));
                      },
                    ),);
                  },
                  itemCount: list.length,
                ) : const Text('There are currently no saved websites');
              }else{
                return const Center(child: CircularProgressIndicator(),);
              }
            },
          future: FavouritesLogic.getFavouritesSQL(),
        ),

      ),
    );
  }
}
