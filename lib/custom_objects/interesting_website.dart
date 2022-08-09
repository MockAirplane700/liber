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

  @override
  String toString() {
    return 'Website{id: $id, name: $name}';
  }//end to string
}