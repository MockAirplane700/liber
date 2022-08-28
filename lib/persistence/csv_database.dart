import 'dart:io';

import 'package:csv/csv.dart';
import 'package:liber/custom_objects/interesting_website.dart';
import 'package:path_provider/path_provider.dart';

class CsvManager {
  static String directory = '';
  static String stringPath = '';

  static void setDirectory() async{
    directory = (await getApplicationSupportDirectory()).path;
    stringPath = "$directory/csv-savedStores.csv";
  }//end set directory

  static void generateCsv() async {
    try {
      setDirectory();
      List<List<String>> data = [
        // headers
        ['id', 'name', 'datePublished', 'description', 'networkImage', 'websiteUrl', 'source'],
        //row 1
      ];
      String csvData = const ListToCsvConverter().convert(data);
      //File IO
      try {
        //before we write to the file we need to check if the file writing already exists
        final File file = File(stringPath);
        if (await file.exists()) {
          //no need to create a new file
        }else{
          //create the new file
          await file.writeAsString(csvData);
        }//end if-else
      }catch(ioe) {
        throw Exception('File IO error: ${ioe.toString()}');
      }//end try-catch
    }catch (error) {
      throw Exception(error.toString());
    }//end try-catch
  }//end generate csv

  static void addInterestingWebsites(List<String> list) async {
    try {
      final File file = File(stringPath);
      await file.writeAsString(list.toString());
    }catch(error) {
      throw Exception(error.toString());
    }//end try-catch
  }//end add interesting websites

  static readCsv() async {
    try{

      final file = File(stringPath);
      final contents = await file.readAsString();

      final contentsList = contents.split('\n');
      List<List<String>> websites = [];

      for (var value in contentsList) {
        websites.add(value.split(','));
      }//end for loop

      List<InterestingWebsite> interestingWebsites = [];
      for (var element in websites) {
        interestingWebsites.add(
            InterestingWebsite(
                networkImage: element[4], name: element[1], description: element[3],
                datePublished: element[2], source: element[6],
                websiteUrl: element[5], id: element[0]
            )
        );
      }//end for loop

      return interestingWebsites ;
    }catch (error) {
      throw Exception(error.toString());
    }//end try catch
  }//end read csv

  static deleteWebsite(List<InterestingWebsite> websiteList,InterestingWebsite interestingWebsite) {
    try {
      //delete the entry in the list first
      for (var value in websiteList) {
        if(value.websiteUrl == (interestingWebsite.websiteUrl)){
          //delete from list
          websiteList.remove(value);
        }//end if
      }//end for loop
      //delete the file
      final File file = File(stringPath);
      file.delete();
      //create a new file of the same name
      generateCsv();
      //write to the file the new list
      List<InterestingWebsite> row = [];
      for (var value1 in websiteList) {
        // ['id', 'name', 'datePublished', 'description', 'networkImage', 'websiteUrl', 'source'],
        String id = value1.id;
        String name = value1.name;
        String datePublished = value1.datePublished;
        String description = value1.description;
        String networkImage = value1.networkImage;
        String websiteUrl = value1.websiteUrl;
        String source = value1.source;
        String finalString = '$id,$name,$datePublished,$description,$networkImage,$websiteUrl,$source';
        addInterestingWebsites(finalString.split(','));
        row.add(value1);
      }//end for loop
      // returns a list of the new favourites list
      return row;
    }catch (error) {
      throw Exception(error.toString());
    }//end try-catch
  }//end delete website

}//end csv manager