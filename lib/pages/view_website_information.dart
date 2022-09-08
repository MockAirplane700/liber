import 'package:flutter/material.dart';
import 'package:liber/custom_objects/constant_functions.dart';
import 'package:liber/custom_objects/constants.dart';
import 'package:liber/custom_objects/interesting_website.dart';
import 'package:liber/logic/favourites_logic.dart';
import 'package:liber/logic/sql_persistence/database.dart';
import 'package:liber/widgets/search_delegate.dart';

class ViewWebsiteInfo extends StatefulWidget {

  final InterestingWebsite interestingWebsite;

  const ViewWebsiteInfo({Key? key, required this.interestingWebsite}) : super(key: key);

  @override
  State<ViewWebsiteInfo> createState() => _ViewWebsiteInfoState();
}

class _ViewWebsiteInfoState extends State<ViewWebsiteInfo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Website name: ${widget.interestingWebsite.name}', style: const TextStyle(color: textColor),),
        backgroundColor: appBarColor,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
              icon: const Icon(Icons.search)
          )
        ],
        elevation: 0,
        iconTheme: const IconThemeData(color: applicationIconThemeColor),
      ),
      backgroundColor: applicationBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //todo: share the website
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(padding: EdgeInsets.zero, child: IconButton(
                      onPressed: () {
                        //share through a copied link to the clip board
                      },
                      icon: const Icon(Icons.share)
                  ),)
                ],
              ),
              Padding(padding: const EdgeInsets.all(8.0), child: Image.network(widget.interestingWebsite.networkImage,),),
              const Divider(),
              Text('Description: \n${widget.interestingWebsite.description}', style: const TextStyle(color: textColor),),
              const Divider(),
              Text('Date published: ${widget.interestingWebsite.datePublished}',style: const TextStyle(color: textColor),),
              //url launchers
              const Divider(),
              TextButton(
                  onPressed: () {
                    //url launcher
                    ConstantFunctions.launchUrlFromLogic(Uri.parse(widget.interestingWebsite.source));
                  },
                  child: const Text('Visit source', style: TextStyle(color: textColor),)
              ),
              TextButton(
                  onPressed: () {
                    //url launcher
                    ConstantFunctions.launchUrlFromLogic(Uri.parse(widget.interestingWebsite.websiteUrl));
                  },
                  child: const Text('Visit the website', style: TextStyle(color: textColor),)
              ),
              //save as favourite website
              Padding(
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                        onPressed: (){
                            FavouritesLogic.addToFavourites(widget.interestingWebsite);
                            ScaffoldMessenger.of(context).showSnackBar(const  SnackBar(content: Text('Saved')));
                            setState(() {});
                        },
                      backgroundColor: Colors.blueGrey,
                      child: const Icon(Icons.save),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
