import 'package:flutter/material.dart';
import 'package:liber/custom_objects/interesting_website.dart';
import 'package:liber/persistence/mongo_database.dart';

class MongoDemo extends StatefulWidget {
  const MongoDemo({Key? key}) : super(key: key);

  @override
  State<MongoDemo> createState() => _MongoDemoState();
}

class _MongoDemoState extends State<MongoDemo> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mongo test'),
      ),
      body: Center(
        child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List list = snapshot.data as List<Map<String,dynamic>>;
                InterestingWebsite website = InterestingWebsite(
                    networkImage: '', name: '', description: '',
                    datePublished: '', source: '', websiteUrl: '',
                    id: 0.toString(),
                );
                InterestingWebsite resultingWebsite =  website.fromJson(list[0]);
                return Text('Data: ${resultingWebsite.toString()}');
              }else {
                return const Center(child: Text('Empty'),);
              }
            },
          future: MongoDatabase.getDocuments(),
        ),
      ),
    );
  }
}
