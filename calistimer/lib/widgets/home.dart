import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Color(0xFFD6304A),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text('Calistimer', style: TextStyle(color: Colors.white, fontFamily: 'Ubuntu', fontSize: 50),),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _flatButton(context, text: 'EMON', route: '/emon'),
                _flatButton(context, text: 'AMRAP', route: '/amrap'),
                _flatButton(context, text: 'ISOMETRIA', route: '/isometria'),
              ],
            ),
          )
        ],
      ),
    );
  }

  FlatButton _flatButton(BuildContext context, {String text, String route}) {
    return FlatButton(
      child: Text(text, style: TextStyle(fontSize: 24),),
      textColor: Colors.white,
      onPressed: () {
        Navigator.of(context).pushNamed(route);
      },
    );
  }

}