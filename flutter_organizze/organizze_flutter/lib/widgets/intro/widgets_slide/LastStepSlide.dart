import 'package:flutter/material.dart';
import 'package:organizze_flutter/widgets/Login_and_Register/Register.dart';
import 'package:organizze_flutter/widgets/Login_and_Register/login.dart';
import 'package:flutter/services.dart';

class LastStepSlide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: buildColumn(context),
      ),
    );
  }

  Column buildColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text('Cria sua conta grátis',
            style: TextStyle(fontSize: 20, color: Colors.black),
            textAlign: TextAlign.center),
        SizedBox(
          height: 16,
        ),
        Text('Junte-se a nós e comece já',
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center),
        SizedBox(
          height: 40,
        ),
        RaisedButton(
          child: Text('CADASTRE-SE', style: TextStyle(color: Colors.white)),
          color: Theme.of(context).primaryColor,
          onPressed: () {
            _goPage(context, '/register');
          },
        ),
        FlatButton(
          child: Text(
            'Já tenho uma conta',
            style: TextStyle(color: Colors.grey),
          ),
          splashColor: Colors.transparent,
          onPressed: () => _goPage(context, '/login'),
        )
      ],
    );
  }

  void _goPage(BuildContext context, String page) {
    Navigator.of(context).pushNamed(page);
  }
}
