import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class BackgroundProgress extends StatelessWidget {

  Widget child;
  double value;
  Duration duration;

  BackgroundProgress({@required this.child, this.value = 0, this.duration = const Duration(seconds: 1)}) { assert(this.child != null); }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Color(0xFF2a0e12),
        ),
        AnimatedContainer(
          duration: duration,
          height: MediaQuery.of(context).size.height * ( 1 - value ),
          color: Theme.of(context).primaryColor
        ),
        child
      ],
    );
  }

}