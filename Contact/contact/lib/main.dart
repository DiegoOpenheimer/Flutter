import 'package:contact/UI/main.dart';
import 'package:flutter/material.dart';


void main() => runApp(MaterialApp(
  color: Colors.red,
  title: "Contatos",
  home: App(),
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    accentColor: Colors.red,
  ),
));