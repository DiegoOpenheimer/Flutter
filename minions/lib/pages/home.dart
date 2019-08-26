import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minions/model/character.dart';

import '../styleguide.dart';
import 'components/CardMinion.dart';
import 'minion-description.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        actions: <Widget>[ Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Icon(Icons.search),
        ) ],
      ),
      body: _body(context),
    );
  }

  Widget _body(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(text: 'Despicable me\n', style: AppTheme.title),
                TextSpan(text: 'Characters', style: AppTheme.subTitle),
              ]
            ),
          ),
        ),
        Expanded(child: _buildList(),)
      ],
    );
  }

  Widget _buildList() {
    Character characterKevin =  characters[0];
    Character characterAgnes =  characters[1];
    return PageView(
      children: <Widget>[
        CardMinion(
          onPress: (Character character) => _goPage(character),
          character: characterKevin,
        ),
        CardMinion(
          onPress: (Character character) => _goPage(character),
          character: characterAgnes,
        )
      ],
    );
  }

  void _goPage(Character character) {
    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation1, animation2) {
        return MinionDescription(character);
      }
    ));
  }
}
