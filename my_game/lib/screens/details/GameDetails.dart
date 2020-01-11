import 'package:flutter/material.dart';
import 'package:my_game/components/CustomAppBar.dart';
import 'package:my_game/model/GameProvider.dart';
import 'package:my_game/shared/utils.dart';

class GameDetailWidget extends StatefulWidget {

  final Game game;

  GameDetailWidget(this.game);

  @override
  _GameDetailWidgetState createState() => _GameDetailWidgetState();
}

class _GameDetailWidgetState extends State<GameDetailWidget> {

  Game game;

  @override
  void initState() {
    super.initState();
    game = widget.game;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        game.name,
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              Game gameEdited = await Navigator.of(context).pushNamed<Game>('/add-edit-game', arguments: game);
              if (gameEdited != null) {
                setState(() {
                  this.game = gameEdited;
                });
              }
            },
            child: Text('Editar', style: TextStyle(color: Colors.white),),
          )
        ],
      ),
      body: _body(),
    );
  }

  Widget _body() {
    ImageProvider image = game.cover != null ?
      MemoryImage(game.cover) :
      AssetImage("assets/noCoverFull");
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(game.name, style: TextStyle(fontSize: 38), maxLines: 5, overflow: TextOverflow.ellipsis,),
          SizedBox(height: 8,),
          game.console != null ? _buildConsoleName() : Container(),
          game.releaseDate != null ? Text(Utils.formatterDate(game.releaseDate), style: TextStyle(fontSize: 20), maxLines: 5, overflow: TextOverflow.ellipsis,) : Container(),
          SizedBox(height: 8,),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(image: image, fit: BoxFit.cover)
              ),
            ),
          )
        ],
      ),
    );
  }

  Column _buildConsoleName() {
    return Column(
          children: <Widget>[
            Text(widget.game.console.name, style: TextStyle(fontSize: 34), maxLines: 5, overflow: TextOverflow.ellipsis,),
            SizedBox(height: 8,)
          ],
        );
  }
}