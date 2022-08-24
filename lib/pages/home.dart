import 'package:flutter/material.dart';
import 'package:liber/custom_objects/constants.dart';
import 'package:liber/custom_objects/interesting_website.dart';
import 'package:liber/logic/interesting_websites.dart';
import 'package:liber/pages/view_website_information.dart';
import 'package:liber/widgets/bottom_navigation_bar.dart';
import 'package:liber/widgets/custom_navigation_drawer.dart';
import 'package:liber/widgets/search_delegate.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<InterestingWebsite> interestingWebsites = InterestingWebsites.fetch();

  @override
  Widget build(BuildContext context) {
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
