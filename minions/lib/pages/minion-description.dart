import 'package:flutter/material.dart';
import 'package:minions/model/character.dart';

import '../styleguide.dart';

class MinionDescription extends StatelessWidget {

  final Character character;

  MinionDescription(this.character);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: 'container-${character.name}',
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: character.colors,
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft
                  )
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                child: _body(context)
            ),
          )
        ],
      ),
    );
  }

  Widget _body(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        IconButton(icon: Icon(Icons.close), iconSize: 36,color: Colors.white, onPressed: () => Navigator.of(context).pop()),
        Align(
          alignment: Alignment.centerRight,
          child: Hero(
            tag: 'image-${character.name}',
            child: Image.asset(character.imagePath, height: MediaQuery.of(context).size.height * .4,),
          ),
        ),
        Text(character.name, style: AppTheme.heading, textAlign: TextAlign.start,),
        SizedBox(height: 16,),
        Text(character.description, style: AppTheme.subHeading, textAlign: TextAlign.justify,)
      ],
    );

  }
}
