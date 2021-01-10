import 'package:flutter/cupertino.dart';

class FavoriModel {
  String id;
  String kullanici_Id;
  String favori_Id;
  String moviename;
  String imgurl;
  String overview;
  String budget;
  String duration;
  String date;

  FavoriModel(
      {@required this.id,
      @required this.kullanici_Id,
      @required this.favori_Id,
      @required this.moviename,
      @required this.imgurl,
      @required this.overview,
      @required this.budget,
      @required this.duration,
      @required this.date});

  factory FavoriModel.fromJSON(Map<String, dynamic> favori) {
    return FavoriModel(
        id: favori["_id"],
        kullanici_Id: favori["kullanici_Id"],
        favori_Id: favori["favori_Id"],
        moviename: favori["moviename"],
        imgurl: favori["imgurl"],
        overview: favori["overview"],
        budget: favori["budget"],
        duration: favori["duration"],
        date: favori["date"]);
  }
}
