import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OptionWidget extends StatelessWidget {

  final String title;
  final IconData icon;
  final String route;
  final AnimationController animation;
  final Function onPress;
  Animation _animation;

  OptionWidget({
    @required this.title,
    @required this.icon,
    @required this.route,
    @required this.animation,
    this.onPress
  }) : assert(title != null),
    assert(icon != null),
    assert(route != null) {
      _animation = Tween(begin: -200.0, end: 0.0).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.elasticOut
      ));
    }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      onTap: () {
        if (onPress != null) {
          onPress();
        } else {
          Get.toNamed(route);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _animation.value),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 2000),
                opacity: _animation.value >= -180 ? 1 : 0,
                child: child,
              ),
            );
          },
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.orange[700],
                size: 30,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                title,
                style: Theme.of(Get.context).textTheme.headline5,
              )
            ],
          )),
      ),
    );;
  }
}