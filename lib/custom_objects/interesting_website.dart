class InterestingWebsite {

  final String name;
  final String datePublished;
  final String description;
  final String networkImage;
  final String websiteUrl;
  final String source;
  final int id;

  InterestingWebsite({
    required this.networkImage, required this.name, required this.description,
    required this.datePublished, required this.source, required this.websiteUrl, required this.id
});

  InterestingWebsite fromJson(json) {
    return InterestingWebsite(
        networkImage: json['networkImage'], name:json['name'], description: json['description'],
        datePublished:json['datePublished'], source: json['source'],
        websiteUrl: json['websiteUrl'], id: json['id']
    );
  }
  //Convert a website into a Map, the keys must correspond with names of the columns in the database
  Map<String,dynamic> toMap() {
    return {
      'id':id,
      'name': name,
      'published':datePublished,
      'description':description,
      'networkImage':networkImage,
      'websiteUrl':websiteUrl,
      'source':source
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'name':name,
      'datePublished' : datePublished,
      'description':description,
      'networkImage': networkImage,
      'websiteUrl':websiteUrl,
      'source': source,
      'id':id
    };
  }

  @override
  String toString() {
    return 'Website{id: $id, name: $name}';
  }//end to string
}