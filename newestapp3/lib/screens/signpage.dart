import 'package:flutter/material.dart';
import 'package:newestapp3/userprovider.dart';
import 'package:provider/provider.dart';

import 'emailandpassword.dart';

class SignPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserProvider _userprovider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 8 / 10,
          height: MediaQuery.of(context).size.height * 0.5 / 10,
          decoration: BoxDecoration(
            color: Colors.deepOrangeAccent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: FlatButton(
            child: Text("Login"),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => EmailandPassword()),
              );
            },
          ),
        ),
      ),
    );
  }
}
