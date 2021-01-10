import 'package:flutter/material.dart';

class HeaderButton extends StatefulWidget {
  String text;
  bool aktif;
  HeaderButton({@required this.text, @required this.aktif});
  @override
  _HeaderButtonState createState() => _HeaderButtonState();
}

class _HeaderButtonState extends State<HeaderButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.1 / 10),
      decoration: BoxDecoration(
        color: widget.aktif == true ? Colors.orangeAccent : Colors.white,
        border: Border.all(color: Colors.black, width: 0.8),
      ),
      height: MediaQuery.of(context).size.height * 0.7 / 10,
      width: MediaQuery.of(context).size.width * 3 / 10,
      child: Center(
        child: FlatButton(
            onPressed: () {
              setState(() {
                if (widget.aktif == false) {
                  widget.aktif = true;
                } else {
                  widget.aktif = false;
                }
              });
            },
            child: Text(
              "${widget.text}",
              style: TextStyle(
                  color: widget.aktif == true ? Colors.white : Colors.grey),
            )),
      ),
    );
  }
}
