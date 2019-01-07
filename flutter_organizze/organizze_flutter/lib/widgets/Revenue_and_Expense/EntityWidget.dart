import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class EntityWidget extends StatefulWidget {

  String operation;

  EntityWidget({@required this.operation});

  @override
  _EntityWidgetState createState() => _EntityWidgetState();

}

class _EntityWidgetState extends State<EntityWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }

}