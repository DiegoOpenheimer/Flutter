import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_todo/pages/AddTodo/AddTodoWidget.dart';
import 'package:flutter_todo/pages/Home/HomeWidget.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        primaryColor:  Color(0xff6f00f8),
      ),
      color: Color(0xff6f00f8),
      title: 'Todo',
      home: HomeWidget(),
    );
  }

}
