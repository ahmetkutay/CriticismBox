import 'package:flutter/material.dart';
import 'package:newestapp3/model/yorum.dart';

class Comments extends StatelessWidget {
  AsyncSnapshot<dynamic> snapshot;

  Comments({@required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        List<Yorum> comments = snapshot.data;
        return Container(
          margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.20 / 10,
              horizontal: MediaQuery.of(context).size.width * 0.4 / 10),
          height: MediaQuery.of(context).size.height * 2 / 10,
          width: MediaQuery.of(context).size.width * 8 / 10,
          decoration: BoxDecoration(
              color: Colors.orangeAccent,
              border: Border.all(color: Colors.orangeAccent),
              borderRadius: BorderRadius.circular(5)),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1 / 10,
                  left: MediaQuery.of(context).size.width * 0.4 / 10,
                ),
                alignment: Alignment.topLeft,
                child: Text(
                  "${comments[index].kullanici_name}",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.orangeAccent)),
                  margin: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * 1.3 / 10,
                  child: ListView(
                    children: [
                      Text(
                        "${comments[index].kullanici_yorum}",
                        style:
                            TextStyle(color: Colors.orangeAccent, fontSize: 13),
                      )
                    ],
                  ))
            ],
          ),
        );
      },
    );
  }
}
