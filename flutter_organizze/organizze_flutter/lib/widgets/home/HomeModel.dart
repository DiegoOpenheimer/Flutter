import 'package:organizze_flutter/model/Movement.dart';

class HomeModel {

  bool _userIsConnected = true;

  String currentKey;

  List<Movement> _movements = List();

  int _year = DateTime.now().year;


  int get year => _year;

  set year(int value) {
    _year = value;
  }

  List<Movement> get movements => _movements;

  set movements(List<Movement> movements) => _movements = movements;

  bool get userIsConnected => _userIsConnected;

  set userIsConnected(bool value) {
    _userIsConnected = value;
  }

  HomeModel() {
    currentKey = '''${DateTime.now().month}$year''';
  }


}