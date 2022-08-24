import 'dart:math';

import 'package:mongo_dart/mongo_dart.dart';

class InterestingWebsite {

  final String id;
  final String name;
  final String datePublished;
  final String description;
  final String networkImage;
  final String websiteUrl;
  final String source;


  InterestingWebsite({
    required this.networkImage, required this.name, required this.description,
    required this.datePublished, required this.source, required this.websiteUrl, required this.id
});

  // "CREATE TABLE interestingWebsites(uid INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, networkImage TEXT,"
  // "description TEXT, datePublished TEXT, source TEXT, websiteUrl TEXT, id TEXT)"

  InterestingWebsite fromJson(json) {
    return InterestingWebsite(
         name:json['name'],networkImage: json['networkImage'], description: json['description'],
        datePublished:json['datePublished'], source: json['source'],
        websiteUrl: json['websiteUrl'], id: json['_id'].toHexString()
    );
  }
  //Convert a website into a Map, the keys must correspond with names of the columns in the database

  // "CREATE TABLE interestingWebsites(uid INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, networkImage TEXT,"
  // "description TEXT, datePublished TEXT, source TEXT, websiteUrl TEXT, id TEXT)"

  Map<String,dynamic> toMap() {
    return {
      'name': name,
      'networkImage':networkImage,
      'description':description,
      'datePublished':datePublished,
      'source':source,
      'websiteUrl':websiteUrl,
      'id':id,
    };
  }

  // "CREATE TABLE interestingWebsites(uid INT PRIMARY KEY autoincrement, name TEXT, networkImage TEXT,"
  // "description TEXT, datePublished TEXT, source TEXT, websiteUrl TEXT, id TEXT)"

  Map<String, dynamic> toJson() {
    return {
      'name':name.toString(),
      'networkImage': networkImage.toString(),
      'description':description.toString(),
      'datePublished' : datePublished.toString(),
      'source': source.toString(),
      'websiteUrl':websiteUrl.toString(),
      'id':id.toString()
    };
  }

  @override
  String toString() {
    return 'Website{id: $id, name: $name}';
  }//end to string
}