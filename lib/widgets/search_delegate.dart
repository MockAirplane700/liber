import 'package:flutter/material.dart';
import 'package:liber/custom_objects/constant_functions.dart';
import 'package:liber/custom_objects/interesting_website.dart';
import 'package:liber/logic/interesting_websites.dart';
import 'package:liber/pages/view_website_information.dart';

class CustomSearchDelegate extends SearchDelegate{
  late List interestingWebsites = ConstantFunctions.populateSearchDelegate();
  int indexValue = 0;

  @override
  List<Widget>? buildActions(BuildContext context) {

    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear)
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {

    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    return  ListTile(
      leading: Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.width/80), child: Image.network(interestingWebsites[indexValue].networkImage),),
      title: Text('Name: ${interestingWebsites[indexValue].name}'),
      subtitle: Text(interestingWebsites[indexValue].description, overflow: TextOverflow.ellipsis,),
      trailing: const Icon(Icons.drag_indicator),
      onTap: () {
        //go to view website
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewWebsiteInfo(interestingWebsite: interestingWebsites[indexValue])));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List suggestions = interestingWebsites.where((element) {
      final elementNameComparison = element.name.toLowerCase();
      final input = query.toLowerCase();
      return elementNameComparison.contains(input);
    }).toList();
    return ListView.builder(
        itemBuilder: (context, index) {
          if (suggestions.isEmpty) {
            return const Center(child: CircularProgressIndicator(),);
          }else{
            return  ListTile(
              leading: Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.width/80), child: Image.network(suggestions[index].networkImage),),
              title: Text('Name: ${suggestions[index].name}'),
              subtitle: Text(suggestions[index].description, overflow: TextOverflow.ellipsis,),
              trailing: const Icon(Icons.drag_indicator),
              onTap: () {
                //go to view website
                // Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewWebsiteInfo(interestingWebsite: suggestions[index])));
                query = suggestions[index].name;
                showResults(context);
              },
            );
          }//end else
        },
      itemCount: suggestions.length,
    );
  }
  
}