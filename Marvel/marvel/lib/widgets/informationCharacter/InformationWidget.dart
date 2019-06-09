import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marvel/model/marvel-model.dart';

class InformationWidget extends StatefulWidget {

  @override
  InformationState createState() => InformationState();

}

class InformationState extends State<InformationWidget> with SingleTickerProviderStateMixin {

  AnimationController _animationController;
  Animation<double> _animationBorder;

  double _paddingTop = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animationBorder = Tween(begin: 0.0, end: 100.0).animate(_animationController);
    _animationController.forward();

  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;
    Character character = arguments['character'];
    String image = arguments['image'];
    CupertinoNavigationBar cupertinoNavigationBar = CupertinoNavigationBar(
      middle: Text(character.name),
      previousPageTitle: 'BACK',
    );
    _paddingTop = cupertinoNavigationBar.preferredSize.height + MediaQuery.of(context).padding.top;
    return CupertinoPageScaffold(
      navigationBar: cupertinoNavigationBar,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: _body(character, image),
      ),
    );
  }

  Widget _body(Character character, String image) {
    return Column(
      children: <Widget>[
        SizedBox(height: _paddingTop,),
        Hero(
          transitionOnUserGestures: true,
          tag: character.id,
          child: AnimatedBuilder(
            animation: _animationBorder,
            builder: (context, widget) {
              return Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(_animationBorder.value)),
                    image: DecorationImage(image: CachedNetworkImageProvider(image), fit: BoxFit.cover)
                ),
              );
            }
          ),
        )
      ],
    );
  }

}
