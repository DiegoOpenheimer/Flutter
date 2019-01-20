import 'package:flutter/material.dart';

class ComponentTitle extends StatelessWidget {

  String title;
  String subTitle;
  Color colorTitle;
  Color colorSubTitle;
  double spacing;
  double fontSizeTitle;
  double fontSizeSubTitle;
  String fontFamily;

  ComponentTitle({
    this.title,
    this.subTitle,
    this.colorTitle = Colors.white,
    this.colorSubTitle = Colors.white,
    this.spacing = 0,
    this.fontSizeTitle = 30,
    this.fontSizeSubTitle = 20,
    this.fontFamily = 'Ubuntu'
  }) {
    assert(title != null);
  }

  @override
  Widget build(BuildContext context) {
      return Column(
        children: <Widget>[
          Text(title, style: TextStyle(fontSize: fontSizeTitle, color: colorTitle, fontFamily: fontFamily)),
          SizedBox(height: spacing,),
          subTitle != null ? Text(subTitle, style: TextStyle(fontSize: fontSizeSubTitle, color: colorSubTitle, fontFamily: fontFamily)) : null
        ].where((Widget widget) => widget != null).toList(),
      );
  }
}