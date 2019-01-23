import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {

  Color color;
  double value;
  double totalValue;
  double height;
  Duration duration;

  ProgressBar({
    this.color = Colors.white,
    this.value = 0,
    this.totalValue,
    this.height = 3,
    this.duration = const Duration(seconds: 1),
  });

  @override
  Widget build(BuildContext context) {
    totalValue = totalValue ?? MediaQuery.of(context).size.width;
    return Row(
      children: <Widget>[
        AnimatedContainer(
          duration: duration,
          height: height,
          width: totalValue * value,
          color: color,
        )
      ],
    );
  }
}
