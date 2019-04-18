import 'package:flutter/material.dart';
import 'dart:async';

class ButtonAnimatedWidget extends StatefulWidget {
  @override
  _ButtonAnimatedWidgetState createState() => _ButtonAnimatedWidgetState();
}

class _ButtonAnimatedWidgetState extends State<ButtonAnimatedWidget> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation animationLoading;
  Animation animationBorder;
  Animation animationScale;
  bool started = true;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4));
    animationBorder = Tween(begin: 5.0, end: 25.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.1)
    ));
    animationScale = Tween(begin: 1.0, end: 50.0).animate(CurvedAnimation(parent: _controller, curve: Interval(0.7, 1.0, curve: Curves.linear)));
    super.initState();
    _controller.addListener(() {
      if (_controller.value > 0.4 && started) {
        _controller.stop();
      }
    });
    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushNamed('/information');
        Timer(const Duration(milliseconds: 700), () {
        _controller.reset();
        started = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * .7;
    animationLoading = Tween(begin: width, end: 50.0).animate(CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.2, curve: Curves.decelerate)));
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(scale: animationScale.value, child: Material(
          borderRadius: BorderRadius.all(Radius.circular(animationBorder.value)),
          color: Colors.redAccent,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(animationBorder.value)),
            onTap: (){
              if (_controller.isCompleted) {
                _controller.reverse();
              } else {
                _controller.forward();
              }
              Timer(const Duration(seconds: 5), () {
                  started = false;
                _controller.forward(from: 0.4);
              });
            },
            child: Container(
              alignment: Alignment.center,
              height: 50.0,
              width: animationLoading.value,
              child: _controller.value < 0.1 ? Text('Login', style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.center) :
              _controller.value <= 0.7 ? Padding(
                padding: EdgeInsets.all(8),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ) : Container(height: 50, width: animationLoading.value,),
            ),
          ),
        ),);
      },
    );
  }
}
