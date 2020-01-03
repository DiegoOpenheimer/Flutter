import 'package:flutter/material.dart';
import 'package:my_game/components/CustomAppBar.dart';

class GamesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Lista de jogos',
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () =>
                  Navigator.of(context).pushNamed('/add-edit-game'),
            )
          ]),
      body: _body(),
    );
  }

  Widget _body() {
    return Container();
  }
}
