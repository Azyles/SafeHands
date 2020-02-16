import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Firebase/authentication.dart';
import 'Firebase/root_page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black, // navigation bar color
      statusBarColor: Colors.black, // status bar color
    ));
    return new MaterialApp(
        title: '',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(),
        home: new RootPage(auth: new Auth()));
  }
}
