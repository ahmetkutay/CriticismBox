import 'package:flutter/material.dart';

class FormTextPart extends StatelessWidget {
  TextEditingController controller;
  String title;
  TextInputType textinputtype;

  FormTextPart(
      {@required this.controller,
      @required this.title,
      @required this.textinputtype});
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        margin: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * 5 / 10, bottom: 5),
        child: Text(
          title,
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 1.50 / 10,
            vertical: MediaQuery.of(context).size.width * 0.10 / 10),
        height: MediaQuery.of(context).size.width * 1.2 / 10,
        child: TextFormField(
          obscureText:
              textinputtype == TextInputType.visiblePassword ? true : false,
          keyboardType: textinputtype,
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  width: 2.25,
                  color: Colors.deepOrangeAccent,
                  style: BorderStyle.solid),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2.25,
                  color: Colors.deepOrangeAccent,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    ]);
  }
}
