import 'package:flutter/material.dart';
import 'package:my_game/components/CustomAppBar.dart';
import 'package:my_game/screens/games/GamesController.dart';

class GamesWidget extends StatefulWidget {
  @override
  _GamesWidgetState createState() => _GamesWidgetState();
}

class _GamesWidgetState extends State<GamesWidget> {

  GamesController _gamesController = GamesController();

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

  @override
  void initState() {
    super.initState();
    _gamesController.init();
  }
}
