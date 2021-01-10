import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newestapp3/model/category_model.dart';
import 'package:newestapp3/screens/detailpage.dart';
import 'package:newestapp3/widgets/commenwidget/bottom_navigation.dart';

// ignore: must_be_immutable
class ItemsList extends StatelessWidget {
  int secilen;
  ItemsList(this.con, this.secilen);
  List<Contents> con;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 8 / 10,
            child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: con.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    DetailPage widget = DetailPage(con[index], secilen);
                    Route route = CupertinoPageRoute(
                        builder: (context) => widget,
                        settings: RouteSettings(name: widget.toStringShort()));
                    Navigator.push(context, route);
                  },
                  child: Container(
                    margin: EdgeInsets.all(7),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width * 3.2 / 10,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        colorFilter:
                            ColorFilter.mode(Colors.white, BlendMode.dstATop),
                        alignment: Alignment.center,
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(
                          con[index].imgurl,
                        ),
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 0.8,
                            blurRadius: 0.8)
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          BottomNavigation(),
        ],
      ),
    );
  }
}
