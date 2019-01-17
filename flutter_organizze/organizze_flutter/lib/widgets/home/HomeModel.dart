import 'package:organizze_flutter/model/Movement.dart';
import 'package:organizze_flutter/model/User.dart';

class HomeModel {
  bool _userIsConnected = true;

  String currentKey;

  List<Movement> _movements = List();

  User _user;

  bool _loadUser = false;

  HomeModel() {
    currentKey = '''${DateTime.now().month}$year''';
  }

  User get user => _user;

  set user(User value) {
    _user = value;
  }

  int _year = DateTime.now().year;

  bool _loadListMovements = false;

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

  bool get loadListMovements => _loadListMovements;

  set loadListMovements(bool value) => _loadListMovements = value;

  bool get loadUser => _loadUser;

  set loadUser(bool value) {
    _loadUser = value;
  }
}
