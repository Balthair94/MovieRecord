import 'package:flutter/material.dart';

import 'package:movie_record/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Record',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage()
      },
    );
  }
}