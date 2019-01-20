import 'package:calistimer/widgets/Amrap/AmrapWidget.dart';
import 'package:calistimer/widgets/Isometria/IsometriaWidget.dart';
import 'package:flutter/material.dart';
import 'package:calistimer/widgets/home.dart';
import 'package:calistimer/widgets/Emon/EmonWidget.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Color(0xFFD6304A),
      theme: ThemeData(
        accentColor: Color(0xFFD6304A),
        primaryColor: Color(0xFFD6304A),
        scaffoldBackgroundColor: Color(0xFFD6304A)
      ),
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => Home(),
        '/emon': (BuildContext context) => EmonWidget(),
        '/amrap': (BuildContext context) => AmrapWidget(),
        '/isometria': (BuildContext context) => IsometriaWidget()
      },
      title: 'Calistimer',
    );
  }

}