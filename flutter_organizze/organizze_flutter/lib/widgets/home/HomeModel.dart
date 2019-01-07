class HomeModel {

  bool _userIsConnected = true;

  int _year = DateTime.now().year;


  int get year => _year;

  set year(int value) {
    _year = value;
  }

  bool get userIsConnected => _userIsConnected;

  set userIsConnected(bool value) {
    _userIsConnected = value;
  }


}