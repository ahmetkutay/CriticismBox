import 'package:flutter/material.dart';
import 'package:newestapp3/model/category_model.dart';

class ContentDetail extends StatefulWidget {
  Contents detay;

  ContentDetail({@required this.detay});
  @override
  _ContentDetailState createState() => _ContentDetailState();
}

class _ContentDetailState extends State<ContentDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(5),
      height: MediaQuery.of(context).size.height * 3.1 / 10,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "OVERVİEW",
                style: TextStyle(color: Colors.orangeAccent, fontSize: 12),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 7.2 / 10,
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1 / 10),
            child: Divider(
              thickness: 5,
              color: Colors.orangeAccent,
            ),
          ),
          Text(
            "${widget.detay.overview}",
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.orangeAccent, fontSize: 11),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "DURATION",
                    style: TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                  Text(
                    "${widget.detay.duration}",
                    style: TextStyle(color: Colors.orangeAccent, fontSize: 11),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "BUDGET",
                    style: TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                  Text(
                    "${widget.detay.budget}",
                    style: TextStyle(color: Colors.orangeAccent, fontSize: 11),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "DATE",
                    style: TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                  Text(
                    "${widget.detay.date}",
                    style: TextStyle(color: Colors.orangeAccent, fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1 / 10),
            child: Divider(
              height: 1,
              thickness: 3,
              color: Colors.orangeAccent,
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.45 / 10,
              alignment: Alignment.bottomCenter,
              child: Text(
                "COMMENTS",
                style: TextStyle(
                    color: Colors.orangeAccent, fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
