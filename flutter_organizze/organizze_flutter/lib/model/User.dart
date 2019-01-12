class User {

  String _name;
  String _email;
  String _password;
  double _totalExpenditure;
  double _totalIncoming;


  User([this._name, this._email, this._password, this._totalExpenditure, this._totalIncoming]);



  User.fromMap(Map<String, dynamic> map) {
    _name = map['name'];
    _email = map['email'];
    _totalExpenditure = map['totalExpenditure'].toDouble();
    _totalIncoming = map['totalIncoming'].toDouble();
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get email => _email;

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  double get totalIncoming => _totalIncoming;

  set totalIncoming(double value) {
    _totalIncoming = value;
  }

  double get totalExpenditure => _totalExpenditure;

  set totalExpenditure(double value) {
    _totalExpenditure = value;
  }

  set email(String value) {
    _email = value;
  }

  Map<String, dynamic> toMap() => {
    'name': _name,
    'email': _email,
    'totalExpenditure': _totalExpenditure,
    'totalIncoming': _totalIncoming,
  };

  @override
  String toString() {
    return 'User{_name: $_name, _password: $_email, _totalExpenditure: $_totalExpenditure, _totalIncoming: $_totalIncoming}';
  }


}