import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ListGame extends StatefulWidget {
  final PageController pageController;

  ListGame({required this.pageController});

  @override
  _ListGameState createState() => _ListGameState();
}

class _ListGameState extends State<ListGame>
    with AutomaticKeepAliveClientMixin {
  double opacity = 1;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [buildAppBar()],
    );
  }

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(() {
      setState(() {
        double value = 0.5 -
            widget.pageController.offset /
                widget.pageController.position.maxScrollExtent;
        if (value == 0.5) {
          opacity = 1;
        } else {
          opacity = value;
        }
      });
    });
  }

  Widget buildAppBar() {
    return TweenAnimationBuilder(
      tween: Tween(begin: Offset(0, -100), end: Offset(0, 0)),
      curve: Curves.elasticInOut,
      duration: const Duration(milliseconds: 1500),
      builder: (BuildContext context, Offset offset, Widget? child) {
        return Transform.translate(
          offset: offset,
          child: child,
        );
      },
      child: AppBar(
        title: Text(
          'Mega Sena',
          style: Theme.of(context).textTheme.headline5,
        ),
        actions: [
          AnimatedOpacity(
            opacity: opacity.clamp(0.0, 1.0),
            duration: Duration.zero,
            child: IconButton(icon: Icon(Icons.search), onPressed: () {}),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
