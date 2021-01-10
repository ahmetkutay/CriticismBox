import 'package:flutter/material.dart';
import 'package:newestapp3/model/category_model.dart';
import 'package:newestapp3/model/favori_model.dart';
import 'package:newestapp3/screens/detailpage.dart';
import 'package:newestapp3/userprovider.dart';
import 'package:provider/provider.dart';

class _FavoriPageState extends State<FavoriPage> {
  @override
  Widget build(BuildContext context) {
    UserProvider _userprovider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
        children: <Widget>[
          Card(
              elevation: 10,
              shadowColor: Colors.black,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7 / 10,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    "${widget.title}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
              )),
          Container(
            height: MediaQuery.of(context).size.height * 8 / 10,
            child: ListView.builder(
              itemCount: widget.veriler.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Card(
                    color: Colors.orangeAccent,
                    elevation: 5,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.white,
                              margin: EdgeInsets.only(
                                  left: 10, top: 10, bottom: 10),
                              padding: EdgeInsets.all(5),
                              height:
                                  MediaQuery.of(context).size.height * 3 / 10,
                              child: Image.network(
                                  "${widget.veriler[index].imgurl}"),
                            ),
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 3 / 10,
                              width:
                                  MediaQuery.of(context).size.width * 5.5 / 10,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Card(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          bottom: 20,
                                          top: 20,
                                          left: 10,
                                          right: 10),
                                      width: MediaQuery.of(context).size.width *
                                          6 /
                                          10,
                                      child: Center(
                                        child: Text(
                                          "${widget.veriler[index].moviename.toUpperCase()}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orangeAccent),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 10,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            size: 40,
                                            color: Colors.red,
                                          ),
                                          onPressed: () async {
                                            await _userprovider.favoridelete(
                                                widget.veriler[index]
                                                    .kullanici_Id,
                                                widget.veriler[index].id);

                                            setState(() {
                                              widget.veriler.remove(
                                                  widget.veriler[index]);
                                            });
                                          },
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: IconButton(
                                            icon: Icon(
                                              Icons
                                                  .keyboard_arrow_right_outlined,
                                              size: 50,
                                              color: Colors.orangeAccent,
                                            ),
                                            onPressed: () {
                                              Contents deger = Contents(
                                                  widget
                                                      .veriler[index].favori_Id,
                                                  widget
                                                      .veriler[index].moviename,
                                                  widget.veriler[index].imgurl,
                                                  widget.veriler[index].date,
                                                  widget
                                                      .veriler[index].duration,
                                                  widget
                                                      .veriler[index].overview,
                                                  widget.veriler[index].budget);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailPage(
                                                              deger, 1)));
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
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
  }
}

class FavoriPage extends StatefulWidget {
  List<FavoriModel> veriler;
  String title;
  FavoriPage({@required this.veriler, @required this.title});
  @override
  _FavoriPageState createState() => _FavoriPageState();
}
