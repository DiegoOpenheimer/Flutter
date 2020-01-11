import 'package:mobx/mobx.dart';
import 'package:my_game/model/ConsoleProvider.dart';

part 'ConsolesController.g.dart';

class ConsolesController = _ConsolesController with _$ConsolesController;

abstract class _ConsolesController with Store {

  ConsoleProvider _consoleProvider = ConsoleProvider();

  @observable
  ObservableList<Console> consoles = ObservableList();

  @action
  void setConsoles(List<Console> consoles) => this.consoles = consoles.asObservable();

  Future init() async {
    setConsoles(await _consoleProvider.loadConsoles());
  }

  Future createConsole(String name) async {
   Console console = await _consoleProvider.insert(name);
   consoles.add(console);
  }

  Future removeConsole(Console console) async {
    await _consoleProvider.delete(console);
    consoles.remove(console);
  }


}