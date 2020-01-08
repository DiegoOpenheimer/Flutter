

import 'package:my_game/model/GameProvider.dart';

class GamesController {

  GameProvider _gameProvider = GameProvider();

  void init() {
    _gameProvider.loadGames();
  }

}