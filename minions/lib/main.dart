import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minions/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      title: 'Minions',
      color: Colors.white,
      theme: ThemeData(
        accentColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(color: Colors.white, elevation: 0, iconTheme: IconThemeData(color: Colors.black))
      ),
      routes: <String, WidgetBuilder> {
        '/': (context) => HomeWidget()
      }
    );
  }

}
