import 'package:flutter/material.dart';
import 'package:newestapp3/model/yorum.dart';
import 'package:newestapp3/screens/favoripage.dart';
import 'package:newestapp3/widgets/commenwidget/bottom_navigation.dart';
import 'package:provider/provider.dart';

import '../userprovider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    UserProvider _userprovider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 1.8 / 10,
              color: Colors.white,
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.04 / 10),
                    child: Image.asset("lib/assets/box2.jpg"),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(
                  MediaQuery.of(context).size.height * 0.05 / 10),
              height: MediaQuery.of(context).size.height * 0.7 / 10,
              width: MediaQuery.of(context).size.width * 9.8 / 10,
              child: FlatButton(
                  child: Text("FAVORİLER",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange)),
                  onPressed: () {}),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5 / 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: FlatButton(
                      onPressed: () async {
                        var x = await _userprovider
                            .favoriler(_userprovider.user.id);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => FavoriPage(
                              veriler: x,
                              title: "FAVORİ FİLMLER",
                            ),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.movie,
                        color: Colors.blue,
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.5 / 10,
                    width: MediaQuery.of(context).size.width * 3.3 / 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: FlatButton(
                      onPressed: () async {
                        var x = await _userprovider
                            .favoridiziler(_userprovider.user.id);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => FavoriPage(
                              veriler: x,
                              title: "FAVORİ DİZİLER",
                            ),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.tv,
                        color: Colors.green,
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.5 / 10,
                    width: MediaQuery.of(context).size.width * 3.3 / 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: FlatButton(
                      onPressed: () async {
                        var x = await _userprovider
                            .favorikitaplar(_userprovider.user.id);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => FavoriPage(
                              veriler: x,
                              title: "FAVORİ KİTAPLAR",
                            ),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.book,
                        color: Colors.red,
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.5 / 10,
                    width: MediaQuery.of(context).size.width * 3.3 / 10,
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.white,
              thickness: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.7 / 10,
              width: MediaQuery.of(context).size.width * 9.8 / 10,
              child: FlatButton(
                  child: Text("YORUMLAR",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange)),
                  onPressed: () {}),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 5.15 / 10,
                child: FutureBuilder(
                  future:
                      _userprovider.kullaniciyorumListe(_userprovider.user.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Yorum> value = snapshot.data;
                      return ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            height:
                                MediaQuery.of(context).size.height * 2.6 / 10,
                            width: MediaQuery.of(context).size.width * 9 / 10,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("${value[index].kullanici_name}"),
                                  ],
                                ),
                                Container(
                                    padding: EdgeInsets.all(10),
                                    color: Colors.grey.withOpacity(0.4),
                                    height: MediaQuery.of(context).size.height *
                                        1.3 /
                                        10,
                                    width: MediaQuery.of(context).size.height *
                                        6 /
                                        10,
                                    child: Text(
                                      "${value[index].kullanici_yorum}",
                                      maxLines: 10,
                                    )),
                                Row(
                                  children: [
                                    RaisedButton(
                                      color: Colors.red,
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: (context),
                                          builder: ((context) {
                                            return AlertDialog(
                                              title: Text(
                                                  " Silmek İstediginize Emin Misiniz",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.red)),
                                              actions: <Widget>[
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      1 /
                                                      10,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      RaisedButton(
                                                        color: Colors.red,
                                                        onPressed: () async {
                                                          debugPrint(
                                                              value[index]
                                                                  .objectId);
                                                          debugPrint(
                                                              " object Id");
                                                          var deger = await _userprovider
                                                              .yorumsil(
                                                                  _userprovider
                                                                      .user.id,
                                                                  value[index]
                                                                      .objectId);
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          HomePage()));
                                                        },
                                                        child: Text(
                                                          "Evet",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                      RaisedButton(
                                                        color: Colors.blue,
                                                        onPressed: () async {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        HomePage()),
                                                          );
                                                        },
                                                        child: Text(
                                                          "Hayır",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    RaisedButton(
                                      color: Colors.orangeAccent,
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        var _controller = TextEditingController(
                                            text: value[index].kullanici_yorum);
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            actions: [
                                              Center(
                                                child: Container(
                                                  padding: EdgeInsets.all(10),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      7 /
                                                      10,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      4 /
                                                      10,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      TextFormField(
                                                        decoration: InputDecoration(
                                                            border:
                                                                OutlineInputBorder()),
                                                        controller: _controller,
                                                        maxLines: 8,
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            4 /
                                                            10,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.7 /
                                                            10,
                                                        child: RaisedButton(
                                                          color: Colors.green,
                                                          onPressed: () async {
                                                            var deger =
                                                                await _userprovider
                                                                    .yorumupdate(
                                                              Yorum(
                                                                  objectId: value[
                                                                          index]
                                                                      .objectId,
                                                                  kullanici_Id:
                                                                      value[index]
                                                                          .kullanici_Id,
                                                                  kullanici_yorum:
                                                                      _controller
                                                                          .value
                                                                          .text,
                                                                  kullanici_name:
                                                                      value[index]
                                                                          .kullanici_name,
                                                                  urun_Id: value[
                                                                          index]
                                                                      .urun_Id),
                                                            );
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        HomePage(),
                                                              ),
                                                            );
                                                          },
                                                          child: Text("Kaydet"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 30),
                              child: Text(
                                "Kullanıcı Yorumları Yükleniyor",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                            CircularProgressIndicator(),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            BottomNavigation(),
          ],
        ),
      ),
    );
  }
}

// FutureBuilder(
//           //future: ,
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             if (!snapshot.hasData) {
//               return Center(child: CircularProgressIndicator());
//             } else {
//               return ListView.builder(
//                 itemCount: snapshot.data.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Container(
//                     padding: EdgeInsets.all(10),
//                     margin: EdgeInsets.all(10),
//                     height: MediaQuery.of(context).size.height * 2.50 / 10,
//                     width: MediaQuery.of(context).size.width * 9 / 10,
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text("name"),
//                             Text("tarih"),
//                           ],
//                         ),
//                         Container(
//                           child: Image.network(""),
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                         Text("")
//                       ],
//                     ),
//                   );
//                 },
//               );
//             }
//           },
//         ),
