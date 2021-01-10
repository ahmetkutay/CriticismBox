import 'package:flutter/cupertino.dart';

class Yorum {
  String objectId;
  String urun_Id;
  String kullanici_yorum;
  String kullanici_Id;
  String kullanici_name;

  Yorum(
      {this.objectId,
      @required this.urun_Id,
      @required this.kullanici_yorum,
      @required this.kullanici_Id,
      @required this.kullanici_name});

  factory Yorum.fromJSON(Map<String, dynamic> data) {
    return Yorum(
        objectId: data["_Id"],
        urun_Id: data["urun_Id"],
        kullanici_name: data["kullanici_name"],
        kullanici_yorum: data["kullanici_Yorum"],
        kullanici_Id: data["kullanici_Id"]);
  }
}
