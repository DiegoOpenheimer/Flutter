import 'package:flutter/material.dart';
import 'package:my_game/components/CustomAppBar.dart';
import 'package:my_game/shared/constants.dart';
import 'package:my_game/components/Alert.dart';

class ConsolesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        'Plataformas',
        color: CustomColor.secondary,
        actions: <Widget>[
          IconButton(
            onPressed: () => _registerConsole(context),
            icon: Icon(Icons.add),
            color: Colors.white,
          )
        ],
      ),
      body: _body(context),
    );
  }

  Widget _body(context) {
    return Container();
  }

  void _registerConsole(context) {
    Alert.showInputAlert(context, title: 'Cadastrar plataforma', label: 'Nome', onComplete: (String name) {
      // TODO implements save console
    });
  }

}
