import 'dart:typed_data';
import 'package:mobx/mobx.dart';
import 'package:my_game/model/ConsoleProvider.dart';
import 'package:my_game/model/GameProvider.dart';

part 'GameController.g.dart';

class GameController = _GameController with _$GameController;

abstract class _GameController with Store {

  ConsoleProvider _consoleProvider = ConsoleProvider();
  GameProvider _gameProvider = GameProvider();

  Game game;

  @observable
  Console currentConsole;

  @action
  void setCurrentConsole(int value) {
    currentConsole = consoles.firstWhere(
      (console) => console.id == value,
      orElse: () => null
    );
  }

  @observable
  DateTime releaseDate;

  @action
  void setReleaseDate(DateTime date) => releaseDate = date;

  @observable
  Uint8List image;

  @action
  void setImage(Uint8List image) => this.image = image;

  @observable
  List<Console> consoles = [];

  @action void setConsoles(List<Console> consoles) => this.consoles = consoles;

  Future init(Game game) async {
    setConsoles(await _consoleProvider.loadConsoles());
    if (game != null) {
      this.game = game;
      setReleaseDate(game.releaseDate);
      setImage(game.cover);
      setCurrentConsole(game.console?.id);
    }
  }

  Future saveGame(String name) async {
    Game gameTemp = game != null ? game : Game();
    gameTemp
      ..name = name
      ..releaseDate = releaseDate
      ..cover = image
      ..console = currentConsole;
    if (game != null) {
      await _gameProvider.update(gameTemp);
    } else {
      await _gameProvider.insert(gameTemp);
    }
    return game;
  }

  String validateName(String text)  {
    if (text.isEmpty) {
      return 'Preencha o campo nome';
    }
    return null;
  }
}