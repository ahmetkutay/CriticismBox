import 'package:flutter/widgets.dart';

class Category {
  String kategoriId;
  String kategoriname;
  List<Contents> contents;

  Category(
      {@required this.kategoriname,
      @required this.kategoriId,
      @required this.contents});

  factory Category.fromJSON(Map<String, dynamic> subcontent) => Category(
      kategoriname: subcontent["kategoriname"],
      kategoriId: subcontent["_id"],
      contents: subcontent["contents"]
          .map((value) => Contents.fromJSON(value))
          .toList());
}

class Contents {
  String id;
  String moviename;
  String imgurl;
  String date;
  String duration;
  String budget;
  String overview;

  Contents(
      @required this.id,
      @required this.moviename,
      @required this.imgurl,
      @required this.date,
      @required this.duration,
      @required this.overview,
      @required this.budget);

  factory Contents.fromJSON(Map<String, dynamic> value) => Contents(
      value["id"],
      value["moviename"],
      value["imgurl"],
      value["date"],
      value["duration"],
      value["overview"],
      value["budget"]);
}
