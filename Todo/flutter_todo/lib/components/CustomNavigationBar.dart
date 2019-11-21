import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CustomNavigationBar extends CupertinoNavigationBar {

  final String title;
  final Color colorTitle;
  final Color backgroundColor;
  final bool transitionBetweenRoutes;

  CustomNavigationBar({
    @required this.title,
    this.colorTitle = CupertinoColors.white,
    this.backgroundColor = const Color(0xff6f00f8),
    this.transitionBetweenRoutes = true,
  }) :
    assert(title != null),
    super(
      previousPageTitle: 'BACK',
      actionsForegroundColor: Colors.white,
      middle: Text(title, style: TextStyle(color: colorTitle),),
      backgroundColor: backgroundColor,
      transitionBetweenRoutes: transitionBetweenRoutes
    );
}
