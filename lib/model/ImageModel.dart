import 'package:flutter/cupertino.dart';

class ImageModel {
  int totalHits;
  List<Hits> hits;
  int total;

  ImageModel({this.totalHits, this.hits, this.total});
}

class Hits {
 int id;
 String webformatURL;
 String title;
 String description;
 String user;

 Hits (
      {
        this.id,
        this.webformatURL,
        this.title,
        this.description,
        this.user,
      });
}
