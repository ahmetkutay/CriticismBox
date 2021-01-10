import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newestapp3/model/category_model.dart';
import 'package:newestapp3/model/favori_model.dart';
import 'package:newestapp3/model/user_model.dart';
import 'package:newestapp3/model/yorum.dart';

class AuthResponse {
  bool succes;
  Map<String, dynamic> user = {
    "_id": "",
    "name": "",
    "email": "",
    "password": "",
    "_v": ""
  };
}

class Authentication {
  var dio = Dio();
  //////////////////////////////////////////////// CREATE USER  EMAİL USERNAME AND PASSSWORD
  Future<User> createUserEmailandPassword(@required String name,
      @required String email, @required String password) async {
    var response = await dio.post(
        "https://criticismbox.herokuapp.com/api/register",
        data: {"name": name, "email": email, "password": password});

    if (response.statusCode == 200) {
      debugPrint("${response.data.toString()}" + " " + " response kısmı");
      User person = User(
          response.data["name"], response.data["id"], response.data["email"]);
      return person;
    } else {
      return null;
    }
  }

  Future<User> loginEmailandPassword(
      @required String email, @required password) async {
    var response = await dio.post(
        "https://criticismbox.herokuapp.com/api/login",
        data: {"email": email, "password": password});

    if (response.statusCode == 200) {
      debugPrint("${response.data['id'].toString()}" + " " + " response kısmı");

      User person = User(
          response.data["name"], response.data["id"], response.data["email"]);

      return person;
    } else {
      return null;
    }
  }

  List<Contents> getcont(List<dynamic> value) {
    List<Contents> y = [];

    for (var z in value) {
      y.add(Contents(z["id"], z["moviename"], z["imgurl"], z["date"],
          z["duration"], z["overview"], z["budget"]));
    }
    return y;
  }

  //List<Category>
  Future<List<Category>> fetchmovie() async {
    var response =
        await http.get("https://criticismbox.herokuapp.com/api/category/film");
    if (response.statusCode == 200) {
      debugPrint("${response.body}");

      Map<String, dynamic> deger = convert.jsonDecode(response.body);
      var saple = Contents.fromJSON(deger["cat"][0]["contents"][0]);

      List<Category> kat = [];
      for (var x in deger["cat"]) {
        kat.add(
          Category(
            kategoriId: x["_id"],
            kategoriname: x["kategoriname"],
            contents: getcont(x["contents"]),
          ),
        );
      }
      return kat;
    } else {
      return null;
    }
  }

  List<Contents> getdizi(List<dynamic> value) {
    List<Contents> y = [];

    for (var z in value) {
      y.add(Contents(z["id"], z["seriesname"], z["imgurl"], z["date"],
          z["duration"], z["overview"], z["budget"]));
    }
    return y;
  }

  Future<List<Category>> fetchdizi() async {
    var response =
        await http.get("https://criticismbox.herokuapp.com/api/category/dizi");
    if (response.statusCode == 200) {
      debugPrint("${response.body}");

      Map<String, dynamic> deger = convert.jsonDecode(response.body);
      var saple = Contents.fromJSON(deger["cat"][0]["contents"][0]);

      List<Category> kat = [];
      for (var x in deger["cat"]) {
        kat.add(
          Category(
            kategoriId: x["_id"],
            kategoriname: x["kategoriname"],
            contents: getdizi(x["contents"]),
          ),
        );
      }
      return kat;
    } else {
      return null;
    }
  }

  List<Contents> getbook(List<dynamic> value) {
    List<Contents> y = [];

    for (var z in value) {
      y.add(Contents(z["id"], z["kitapname"], z["imgurl"], z["date"],
          z["duration"], z["overview"], z["budget"]));
    }
    return y;
  }

  Future<List<Category>> fetchbook() async {
    var response =
        await http.get("https://criticismbox.herokuapp.com/api/category/kitap");
    if (response.statusCode == 200) {
      debugPrint("${response.body}");

      Map<String, dynamic> deger = convert.jsonDecode(response.body);
      var saple = Contents.fromJSON(deger["cat"][0]["contents"][0]);

      List<Category> kat = [];
      for (var x in deger["cat"]) {
        kat.add(
          Category(
            kategoriId: x["_id"],
            kategoriname: x["kategoriname"],
            contents: getbook(x["contents"]),
          ),
        );
      }
      return kat;
    } else {
      return null;
    }
  }

  Future<bool> favfilmekle(Map<String, dynamic> movie) async {
    debugPrint(movie["_id"].toString());
    var response = await dio.post(
        "https://criticismbox.herokuapp.com/api/users/film_insert_favori",
        data: movie,
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> favdizimekle(Map<String, dynamic> movie) async {
    var response = await dio.post(
        "https://criticismbox.herokuapp.com/api/users/dizi_insert_favori",
        data: movie,
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> favkitapmekle(Map<String, dynamic> movie) async {
    var response = await dio.post(
        "https://criticismbox.herokuapp.com/api/users/kitap_insert_favori",
        data: movie,
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<FavoriModel>> getfav(String id) async {
    debugPrint(id);
    var response = await dio.get(
      "https://criticismbox.herokuapp.com/api/users/film_favori",
      queryParameters: {'_id': "${id.toString()}"},
      options: Options(
        followRedirects: false,
        responseType: ResponseType.plain,
        validateStatus: (status) {
          return status < 500;
        },
      ),
    );

    //debugPrint(response.data.toString());

    if (response.statusCode == 200) {
      Map jsonresponse = convert.jsonDecode(response.data.toString());
      var y = jsonresponse["fav"];
      debugPrint(y.toString());
      List<FavoriModel> liste = [];
      for (var x in y) {
        liste.add(FavoriModel(
            id: x["_id"],
            kullanici_Id: x["kulanici_Id"],
            favori_Id: x["favori_Id"],
            moviename: x["moviename"],
            imgurl: x["imgurl"],
            overview: x["overview"],
            budget: x["budget"],
            duration: x["duration"],
            date: x["date"]));
      }
      return liste;
    } else {
      return null;
    }
  }

  Future<List<FavoriModel>> getfavdizi(String id) async {
    var response = await dio.get(
      "https://criticismbox.herokuapp.com/api/users/dizi_favori",
      queryParameters: {'_id': "${id.toString()}"},
      options: Options(
        followRedirects: false,
        responseType: ResponseType.plain,
        validateStatus: (status) {
          return status < 500;
        },
      ),
    );

    //debugPrint(response.data.toString());

    if (response.statusCode == 200) {
      Map jsonresponse = convert.jsonDecode(response.data.toString());
      var y = jsonresponse["fav"];
      debugPrint(y.toString());
      List<FavoriModel> liste = [];
      for (var x in y) {
        liste.add(FavoriModel(
            id: x["_id"],
            kullanici_Id: x["kulanici_Id"],
            favori_Id: x["favori_Id"],
            moviename: x["moviename"],
            imgurl: x["imgurl"],
            overview: x["overview"],
            budget: x["budget"],
            duration: x["duration"],
            date: x["date"]));
      }
      return liste;
    } else {
      return null;
    }
  }

  Future<List<FavoriModel>> getfavkitap(String id) async {
    debugPrint(id.toString());
    var response = await dio.get(
      "https://criticismbox.herokuapp.com/api/users/kitap_favori",
      queryParameters: {'_id': "${id.toString()}"},
      options: Options(
        followRedirects: false,
        responseType: ResponseType.plain,
        validateStatus: (status) {
          return status < 500;
        },
      ),
    );

    //debugPrint(response.data.toString());

    if (response.statusCode == 200) {
      Map jsonresponse = convert.jsonDecode(response.data.toString());
      var y = jsonresponse["fav"];
      debugPrint(y.toString());
      List<FavoriModel> liste = [];
      for (var x in y) {
        liste.add(FavoriModel(
            id: x["_id"],
            kullanici_Id: x["kulanici_Id"],
            favori_Id: x["favori_Id"],
            moviename: x["moviename"],
            imgurl: x["imgurl"],
            overview: x["overview"],
            budget: x["budget"],
            duration: x["duration"],
            date: x["date"]));
      }
      return liste;
    } else {
      return null;
    }
  }

  Future<List<Yorum>> getconcomments(String id) async {
    var response = await dio.get(
      "https://criticismbox.herokuapp.com/api/users/urun_yorum",
      queryParameters: {'urun_Id': "${id.toString()}"},
      options: Options(
        followRedirects: false,
        responseType: ResponseType.plain,
        validateStatus: (status) {
          return status < 500;
        },
      ),
    );
    if (response.statusCode == 200) {
      Map jsonresponse = convert.jsonDecode(response.data.toString());
      var y = jsonresponse["fav"];
      debugPrint(y.toString());
      List<Yorum> liste = [];
      for (var x in y) {
        liste.add(
          Yorum(
            kullanici_name: x["kullanici_name"],
            kullanici_Id: x["kullanici_Id"],
            kullanici_yorum: x["kullanici_Yorum"],
            urun_Id: x["urun_Id"],
          ),
        );
      }
      return liste;
    } else {
      return null;
    }
  }

  Future<bool> insertyorum(Yorum x) async {
    debugPrint(x.kullanici_Id);
    debugPrint(x.urun_Id);
    debugPrint(x.kullanici_yorum);

    var response = await dio.post(
      "https://criticismbox.herokuapp.com/api/users/yorum_insert",
      data: {
        '_id': x.kullanici_Id,
        'kullaniciAdi': x.kullanici_name,
        'fav_Id': x.urun_Id,
        'yorum': x.kullanici_yorum
      },
      options: Options(
        followRedirects: false,
        responseType: ResponseType.plain,
        validateStatus: (status) {
          return status < 500;
        },
      ),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      debugPrint("Yorum eklerekn bir hata çıktı");
      return false;
    }
  }

  Future<List<Yorum>> getuseryorum(String id) async {
    var response = await dio.get(
      "https://criticismbox.herokuapp.com/api/users/yorum",
      queryParameters: {'kullanici_id': "${id.toString()}"},
      options: Options(
        followRedirects: false,
        responseType: ResponseType.plain,
        validateStatus: (status) {
          return status < 500;
        },
      ),
    );
    if (response.statusCode == 200) {
      Map jsonresponse = convert.jsonDecode(response.data.toString());
      var y = jsonresponse["fav"];
      debugPrint(y.toString());
      List<Yorum> liste = [];
      for (var x in y) {
        liste.add(
          Yorum(
            objectId: x["_id"],
            kullanici_name: x["kullanici_name"],
            kullanici_Id: x["kullanici_Id"],
            kullanici_yorum: x["kullanici_Yorum"],
            urun_Id: x["urun_Id"],
          ),
        );
      }
      return liste;
    } else {
      return null;
    }
  }

  Future<bool> yorumsil(String userId, String objectId) async {
    var response = await dio.post(
      "https://criticismbox.herokuapp.com/api/users/yorum_delete",
      data: {"kullanici_id": userId, "_id": objectId},
      options: Options(
        followRedirects: false,
        responseType: ResponseType.plain,
        validateStatus: (status) {
          return status < 500;
        },
      ),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> yorumupdate(Yorum x) async {
    var response = await dio.post(
      "https://criticismbox.herokuapp.com/api/users/yorum_update",
      data: {
        "kullanici_id": x.kullanici_Id,
        "_id": x.objectId,
        "fav_Id": x.urun_Id,
        "kullaniciAdi": x.kullanici_name,
        "yorum": x.kullanici_yorum
      },
      options: Options(
        followRedirects: false,
        responseType: ResponseType.plain,
        validateStatus: (status) {
          return status < 500;
        },
      ),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> favoridelete(String userId, String objectId) async {
    var response = await dio.post(
      "https://criticismbox.herokuapp.com/api/users/favori_delete",
      data: {"kullanici_id": userId, "_id": objectId},
      options: Options(
        followRedirects: false,
        responseType: ResponseType.plain,
        validateStatus: (status) {
          return status < 500;
        },
      ),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
