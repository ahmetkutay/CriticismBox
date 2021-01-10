import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:newestapp3/model/category_model.dart';
import 'package:newestapp3/model/user_model.dart';
import 'package:newestapp3/model/yorum.dart';
import 'package:newestapp3/userprovider.dart';
import 'package:newestapp3/widgets/commenwidget/bottom_navigation.dart';
import 'package:newestapp3/widgets/detailpage/comments.dart';
import 'package:newestapp3/widgets/detailpage/content.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  Contents con;
  int secilen;
  DetailPage(this.con, this.secilen);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    UserProvider _userprovider = Provider.of<UserProvider>(context);
    final formKey = GlobalKey<FormState>();
    final _controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            Container(
              height: MediaQuery.of(context).size.height * 8 / 10,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 3.5 / 10,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.bottomCenter,
                            height:
                                MediaQuery.of(context).size.height * 3.5 / 10,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.white, BlendMode.dstATop),
                                alignment: Alignment.center,
                                fit: BoxFit.fitWidth,
                                image: NetworkImage(
                                  "${widget.con.imgurl}",
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * 2.9 / 10,
                            child: Container(
                                alignment: Alignment.center,
                                height: MediaQuery.of(context).size.height *
                                    0.60 /
                                    10,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.black.withOpacity(0.68),
                                child: Text(
                                  "${widget.con.moviename}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          Positioned(
                              left:
                                  MediaQuery.of(context).size.width * 7.6 / 10,
                              child: RaisedButton(
                                child: Icon(Icons.add),
                                onPressed: () {
                                  User x = _userprovider.user;
                                  Map<String, dynamic> favori = {
                                    "_id": x.id,
                                    "fav_Id": widget.con.id,
                                    "moviename": widget.con.moviename,
                                    "imgurl": widget.con.imgurl,
                                    "overview": widget.con.overview,
                                    "date": widget.con.date,
                                    "duration": widget.con.duration,
                                    "budget": widget.con.budget,
                                  };
                                  if (widget.secilen == 0) {
                                    _userprovider.favorifilmekle(favori);
                                  } else if (widget.secilen == 1) {
                                    _userprovider.favoridizimekle(favori);
                                  } else if (widget.secilen == 2) {
                                    _userprovider.favorikitapekle(favori);
                                  }
                                },
                              ))
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        // borderRadius: BorderRadius.only(
                        //   bottomLeft: Radius.circular(10),
                        //   bottomRight: Radius.circular(10),
                        // ),
                      ),
                      height: MediaQuery.of(context).size.height * 0.35 / 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            widget.secilen != 2 ? "IMDB : 9.7" : "",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.5,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.secilen != 2 ? "CRITISICM : 9.7" : "",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.5,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            height:
                                MediaQuery.of(context).size.height * 0.3 / 10,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.white, width: 1.5),
                                  borderRadius: BorderRadius.circular(10)),
                              color: Colors.orangeAccent,
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: SingleChildScrollView(
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                5 /
                                                10,
                                        child: Form(
                                          key: formKey,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      4 /
                                                      10,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      6 /
                                                      10,
                                                  child: TextFormField(
                                                      controller: _controller,
                                                      maxLines: 9,
                                                      decoration: InputDecoration(
                                                          border:
                                                              OutlineInputBorder()))),
                                              RaisedButton(
                                                color: Colors.blue,
                                                onPressed: () async {
                                                  String yorum =
                                                      _controller.value.text;

                                                  User user =
                                                      _userprovider.user;

                                                  bool answer =
                                                      await _userprovider
                                                          .yorumekle(Yorum(
                                                              urun_Id:
                                                                  widget.con.id,
                                                              kullanici_yorum:
                                                                  yorum,
                                                              kullanici_Id:
                                                                  user.id,
                                                              kullanici_name:
                                                                  user.name));

                                                  Navigator.pop(context);
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailPage(widget.con,
                                                              widget.secilen),
                                                    ),
                                                  ).then((value) {});
                                                },
                                                child: Text(
                                                  "Yorum Yap",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    ContentDetail(detay: widget.con),
                    FutureBuilder(
                      future: _userprovider.content_comments(widget.con.id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.orangeAccent, width: 3)),
                              height:
                                  MediaQuery.of(context).size.height * 5.8 / 10,
                              child: Comments(
                                snapshot: snapshot,
                              ));
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            BottomNavigation(),
          ]),
        ),
      ),
    );
  }
}
