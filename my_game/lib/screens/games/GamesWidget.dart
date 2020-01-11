import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_game/components/CustomAppBar.dart';
import 'package:my_game/components/CustomDismissable.dart';
import 'package:my_game/model/GameProvider.dart';
import 'package:my_game/screens/games/controller/GamesController.dart';

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
              onPressed: () async {
                await Navigator.of(context).pushNamed('/add-edit-game');
                _gamesController.init();
              }
            )
          ]),
      body: _body(),
    );
  }

  Widget _body() {
    return Observer(
      builder: (_) {
        return ListView.separated(
          separatorBuilder: (c, i) => Divider(height: 1,),
          itemCount: _gamesController.games.length,
          itemBuilder: (_, int index) => _item(_gamesController.games[index]),
        );
      },
    );
  }

  Widget _item(Game game) {
    Image image = game.cover == null ?
    Image.asset('assets/noCover.png', fit: BoxFit.cover, height: 70, width: 70,) :
    Image.memory(game.cover, fit: BoxFit.cover, height: 70, width: 70);
    return CustomDismissable(
      onDismiss: (_) => _gamesController.delete(game),
      id: game.id.toString(),
      child: _buildContentListItem(game, image),
    );
  }

  Material _buildContentListItem(Game game, Image image) {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('/game-detail', arguments: game);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              image,
              SizedBox(width: 16,),
              Expanded(
                child: Text(game.name, overflow: TextOverflow.ellipsis, maxLines: 2,),
              ),
              Icon(Icons.arrow_forward, color: Colors.grey,)
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _gamesController.init();
  }
}
