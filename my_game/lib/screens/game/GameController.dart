import 'dart:typed_data';

import 'package:rxdart/rxdart.dart';

class GameController {

  BehaviorSubject<String> controllerConsole = BehaviorSubject();

  BehaviorSubject<DateTime> controllerReleaseDate = BehaviorSubject();

  BehaviorSubject<Uint8List> controllerImage = BehaviorSubject();

  List<String> consoles = ['xbox', 'nintendo', 'playstation', 'mega drive'];

  String validateName(String text)  {
    if (text.isEmpty) {
      return 'Preencha o campo nome';
    }
    return null;
  }


  void dispose() {
    controllerConsole.close();
    controllerReleaseDate.close();
    controllerImage.close();
  }

}