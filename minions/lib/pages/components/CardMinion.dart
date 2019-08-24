import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minions/model/character.dart';
import 'package:meta/meta.dart';

import '../../styleguide.dart';

typedef void OnPress(Character character);

class CardMinion extends StatelessWidget {

  final Character character;
  final OnPress onPress;

  CardMinion({ @required this.character, @required this.onPress });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(character),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: <Widget>[
            buildAlign(context),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'image-${character.name}',
                  child: Image.asset(character.imagePath, height: MediaQuery.of(context).size.height * .55,)
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(character.name, style: AppTheme.heading),
                      Text('Tap to read more', style: AppTheme.subHeading)
                    ],
                  ),
                )
              ],
            )
          ],
        )
      ),
    );
  }

  Align buildAlign(BuildContext context) {
    return Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
                clipper: CustomPath(),
                child: Hero(
                  tag: 'container-${character.name}',
                  child: Container(
                    height: MediaQuery.of(context).size.height * .6,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: character.colors,
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(40))
                    ),
                  ),
                ),
            ),
          );
  }
}

class CustomPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path =  Path();
    double curveDistance = 40;
    path.moveTo(0, size.height * .4);
    path.quadraticBezierTo(0, size.height * .4 - curveDistance, curveDistance, size.height * .4 - curveDistance - 15);
    path.lineTo(size.width - curveDistance, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;

}
