import 'dart:typed_data';
import 'package:mobx/mobx.dart';

part 'GameController.g.dart';

class GameController = _GameController with _$GameController;

abstract class _GameController with Store {

  @observable
  String currentConsole;

  @action
  void setCurrentConsole(String value) => currentConsole = value;

  @observable
  DateTime releaseDate;

  @action
  void setReleaseDate(DateTime date) => releaseDate = date;

  @observable
  Uint8List image;

  @action
  void setImage(Uint8List image) => this.image = image;

  List<String> consoles = ['xbox', 'nintendo', 'playstation', 'mega drive'];

  String validateName(String text)  {
    if (text.isEmpty) {
      return 'Preencha o campo nome';
    }
    return null;
  }
}