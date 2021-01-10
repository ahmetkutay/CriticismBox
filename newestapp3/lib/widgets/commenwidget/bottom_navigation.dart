import 'package:flutter/material.dart';
import 'package:newestapp3/screens/category_page.dart';
import 'package:newestapp3/screens/homepage.dart';

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orangeAccent.withOpacity(0.7),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.8 / 10,
      padding: EdgeInsets.only(top: 3),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8 / 10,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Icon(
                    Icons.movie,
                    size: 40,
                    color: Colors.orangeAccent,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryPage()));
                  },
                  child: Icon(
                    Icons.category,
                    color: Colors.orangeAccent,
                    size: 40,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
