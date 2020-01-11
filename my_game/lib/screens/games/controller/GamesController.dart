

import 'package:mobx/mobx.dart';
import 'package:my_game/model/GameProvider.dart';

part 'GamesController.g.dart';

class GamesController = _GamesController with _$GamesController;

abstract class _GamesController with Store {

  GameProvider _gameProvider = GameProvider();

  @observable
  ObservableList<Game> games = ObservableList();

  @action void setGames(List<Game> games) => this.games = games.asObservable();

  Future<void> init() async {
    setGames(await _gameProvider.loadGames());
  }


}