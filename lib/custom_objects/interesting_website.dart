import 'dart:math';

import 'package:mongo_dart/mongo_dart.dart';

class InterestingWebsite {

  final int id;
  final String name;
  final String datePublished;
  late final String description;
  final String networkImage;
  final String websiteUrl;
  final String source;


  InterestingWebsite({
    required this.networkImage, required this.name, required this.description,
    required this.datePublished, required this.source, required this.websiteUrl, required this.id
});

  // "CREATE TABLE websites(websiteId INTEGER PRIMARY KEY autoincrement,"
  // "name TEXT, datePublished TEXT, networkImage TEXT, description TEXT, websiteUrl TEXT, source TEXT)"

  InterestingWebsite fromJson(json) {
    return InterestingWebsite(
      id: json['websiteId'], name:json['name'],
      datePublished:json['datePublished'],networkImage: json['networkImage'],
      description: json['description'],
      websiteUrl: json['websiteUrl'], source: json['source'],

    );
  }
  //Convert a website into a Map, the keys must correspond with names of the columns in the database

  // "CREATE TABLE websites(websiteId INTEGER PRIMARY KEY autoincrement,"
  // "name TEXT, datePublished TEXT, networkImage TEXT, description TEXT, websiteUrl TEXT, source TEXT)"

  Map<String,dynamic> toMap() {
    return {
      'websiteId':id,
      'name': name,
      'datePublished':datePublished,
      'networkImage':networkImage,
      'description':description,
      'websiteUrl':websiteUrl,
      'source':source,

    };
  }

  // "CREATE TABLE websites(websiteId INTEGER PRIMARY KEY autoincrement,"
  // "name TEXT, datePublished TEXT, networkImage TEXT, description TEXT, websiteUrl TEXT, source TEXT)"

  Map<String, dynamic> toJson() {
    return {
      'websiteId':id,
      'name':name.toString(),
      'datePublished' : datePublished.toString(),
      'networkImage': networkImage.toString(),
      'description':description.toString(),
      'websiteUrl':websiteUrl.toString(),
      'source': source.toString(),


    };
  }

  @override
  String toString() {
    return 'Website{id: $id, name: $name}';
  }//end to string

  void addDescription(String string) {
    description = string;
  }//add description
}