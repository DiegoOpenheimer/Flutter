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
        primaryColor:  Colors.purple,
      ),
      color: Colors.purple,
      title: 'Todo',
      routes: <String, WidgetBuilder>{
        '/': (context) => HomeWidget(),
        '/add-todo': (context) => AddTodoWidget()
      },
    );
  }

}
