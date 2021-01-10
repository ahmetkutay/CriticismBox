import 'package:flutter/material.dart';
import 'package:newestapp3/model/category_model.dart';
import 'package:newestapp3/screens/list.dart';
import 'package:newestapp3/widgets/commenwidget/bottom_navigation.dart';
import 'package:provider/provider.dart';

import '../userprovider.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int secilen = 0;

  Future<List<Category>> getcon(int secilen) async {
    UserProvider _userprovider = Provider.of<UserProvider>(context);
    if (secilen == 0) {
      return await _userprovider.movieget();
    }
    if (secilen == 1) {
      return await _userprovider.diziget();
    }
    if (secilen == 2) {
      return await _userprovider.kitapget();
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider _userprovider = Provider.of<UserProvider>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1.9 / 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            bottom:
                                MediaQuery.of(context).size.height * 0.1 / 10),
                        decoration: BoxDecoration(
                          color:
                              secilen == 0 ? Colors.orangeAccent : Colors.white,
                          border: Border.all(color: Colors.black, width: 0.8),
                        ),
                        height: MediaQuery.of(context).size.height * 0.7 / 10,
                        width: MediaQuery.of(context).size.width * 3 / 10,
                        child: Center(
                          child: FlatButton(
                              onPressed: () {
                                if (secilen != 0) {
                                  setState(() {
                                    secilen = 0;
                                  });
                                }
                              },
                              child: Text(
                                "FİLM",
                                style: TextStyle(
                                    color: secilen == 0
                                        ? Colors.white
                                        : Colors.grey),
                              )),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            bottom:
                                MediaQuery.of(context).size.height * 0.1 / 10),
                        decoration: BoxDecoration(
                          color:
                              secilen == 1 ? Colors.orangeAccent : Colors.white,
                          border: Border.all(color: Colors.black, width: 0.8),
                        ),
                        height: MediaQuery.of(context).size.height * 0.7 / 10,
                        width: MediaQuery.of(context).size.width * 3 / 10,
                        child: Center(
                          child: FlatButton(
                              onPressed: () {
                                if (secilen != 1) {
                                  setState(() {
                                    secilen = 1;
                                  });
                                }
                              },
                              child: Text(
                                "DİZİ",
                                style: TextStyle(
                                    color: secilen == 1
                                        ? Colors.white
                                        : Colors.grey),
                              )),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            bottom:
                                MediaQuery.of(context).size.height * 0.1 / 10),
                        decoration: BoxDecoration(
                          color:
                              secilen == 2 ? Colors.orangeAccent : Colors.white,
                          border: Border.all(color: Colors.black, width: 0.8),
                        ),
                        height: MediaQuery.of(context).size.height * 0.7 / 10,
                        width: MediaQuery.of(context).size.width * 3 / 10,
                        child: Center(
                          child: FlatButton(
                              onPressed: () {
                                if (secilen != 2) {
                                  setState(() {
                                    secilen = 2;
                                  });
                                }
                              },
                              child: Text(
                                "KİTAP",
                                style: TextStyle(
                                    color: secilen == 2
                                        ? Colors.white
                                        : Colors.grey),
                              )),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    height: 2,
                    color: Colors.orangeAccent,
                  ),
                ],
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 7.3 / 10,
                //////////////////////////////////// CONTainer Oluşturan WiDget
                child: FutureBuilder(
                  future: getcon(secilen),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          List<Contents> deger = snapshot.data[index].contents;

                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            width: MediaQuery.of(context).size.width,
                            height:
                                MediaQuery.of(context).size.height * 3.5 / 10,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 4,
                                      color: Colors.grey.withOpacity(0.7),
                                      spreadRadius: 0.7),
                                ],
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black12)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.3 /
                                                10,
                                        vertical:
                                            MediaQuery.of(context).size.height *
                                                0.01 /
                                                10),
                                    height: MediaQuery.of(context).size.height *
                                        0.7 /
                                        10,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 0.8,
                                            blurRadius: 5)
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.height *
                                          0.15 /
                                          10,
                                    ),
                                    alignment: Alignment.bottomLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${snapshot.data[index].kategoriname}",
                                          style: TextStyle(
                                              color: Colors.orangeAccent,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ItemsList(
                                                            deger, secilen)));
                                          },
                                          child: Container(
                                            child: Icon(
                                              Icons.arrow_right_outlined,
                                              size: 40,
                                              color: Colors.orangeAccent,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),

                                //////////////////////////////////////////////// İCERİK LİST VİEW
                                Container(
                                  padding: EdgeInsets.only(right: 3),
                                  height: MediaQuery.of(context).size.height *
                                      2.5 /
                                      10,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: deger.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ItemsList(
                                                          deger, secilen)));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(7),
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              3.2 /
                                              10,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              colorFilter: ColorFilter.mode(
                                                  Colors.white,
                                                  BlendMode.dstATop),
                                              alignment: Alignment.center,
                                              fit: BoxFit.fitWidth,
                                              image: NetworkImage(
                                                deger[index].imgurl,
                                              ),
                                            ),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.7),
                                                  spreadRadius: 0.8,
                                                  blurRadius: 0.8),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                    {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )),
            BottomNavigation(),
          ],
        ));
  }
}

//  secilen == 0
//                       ? _userprovider.movieget()
//                       : secilen == 1
//                           ? _userprovider.diziget()
//                           : _userprovider.kitapget(),
