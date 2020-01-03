import 'package:rxdart/rxdart.dart';

class GameBloc {

  BehaviorSubject<String> controllerConsole = BehaviorSubject();

  List<String> consoles = ['xbox', 'nintendo', 'playstation', 'mega drive'];

  String validateName(String text)  {
    if (text.isEmpty) {
      return 'Preencha o campo nome';
    }
    return null;
  }


  void dispose() {
    controllerConsole.close();
  }

}