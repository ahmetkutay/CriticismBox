import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newestapp3/screens/homepage.dart';
import 'package:newestapp3/screens/signpage.dart';
import 'package:newestapp3/userprovider.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserProvider _userprovider = Provider.of<UserProvider>(context);

    if (_userprovider.durum == Durum.Bos) {
      if (_userprovider.user != null) {
        return HomePage();
      } else {
        return SignPage();
      }
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
