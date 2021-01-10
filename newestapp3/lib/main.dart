import 'package:flutter/material.dart';
import 'package:newestapp3/screens/landingpage.dart';
import 'package:newestapp3/userprovider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => UserProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    ),
  ));
}
