import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CustomNavigationBar extends CupertinoNavigationBar {

  final String title;
  final Color colorTitle;
  final Color backgroundColor;

  CustomNavigationBar({
    @required this.title,
    this.colorTitle = CupertinoColors.white,
    this.backgroundColor = Colors.purple
  }) :
    assert(title != null),
    super(
      actionsForegroundColor: Colors.white,
      middle: Text(title, style: TextStyle(color: colorTitle),),
      backgroundColor: backgroundColor
    );
}
