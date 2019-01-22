import 'package:flutter/material.dart';

class Timer extends StatelessWidget {
  int value;
  Color color;
  String fontFamily;
  double fontSize;
  String appendText;

  Timer(
      {this.value,
      this.color = Colors.white,
      this.fontFamily = 'Ubuntu',
      this.fontSize = 30,
      this.appendText = ''
    });

  @override
  Widget build(BuildContext context) {
    int minutes = value ~/ 60;
    int seconds = value % 60;

    return Text(
      '${_formatter(minutes)}:${_formatter(seconds)}$appendText',
      style: TextStyle(
          color: Colors.white, fontFamily: fontFamily, fontSize: fontSize),
    );
  }

  String _formatter(int value) {
    return value.toString().padLeft(2, '0');
  }
}
