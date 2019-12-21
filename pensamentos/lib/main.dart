import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pensamentos/screens/home/HomeWidget.dart';
import 'package:flutter/material.dart';
import 'package:pensamentos/shared/constants.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Pensamentos',
      theme: CupertinoThemeData(
        primaryColor: Constants.color
      ),
      home: HomeWidget(),
    );
  }
  
}