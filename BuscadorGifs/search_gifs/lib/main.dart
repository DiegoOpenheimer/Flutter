import 'package:flutter/material.dart';
import 'package:search_gifs/UI/main.ui.dart';


void main() => runApp(new MaterialApp(
    color: Colors.black,
    title: "Buscador de gifs",
    theme: ThemeData(hintColor: Colors.white),
    home: new App(),
    debugShowCheckedModeBanner: false,
));