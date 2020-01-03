import 'package:flutter/material.dart';
import 'package:my_game/shared/constants.dart';

class CustomAppBar extends AppBar {

  final String appBarTitle;
  final List<Widget> actions;
  final Color color;
  final Color colorTitle;

  CustomAppBar(this.appBarTitle, {
    this.actions = const [],
    this.color = CustomColor.main,
    this.colorTitle = Colors.white
  }) : super(
    title: Text(appBarTitle, style: TextStyle(color: colorTitle),),
    actions: actions,
    backgroundColor: color
  );
}
