import 'package:flutter/material.dart';
import 'package:pokemon/UI/main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Pokemon',
    color: Colors.blueAccent,
    home: MainView(),
  );

}