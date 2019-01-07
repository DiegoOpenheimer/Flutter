class Movement {

  String _category;
  String _date;
  String _description;
  String _type;
  double _value;

  Movement([this._category, this._date, this._description, this._type,
      this._value]);

  Movement.fromMap(Map<String, dynamic> map) {
    _category = map['category'];
    _date = map['date'];
    _description = map['description'];
    _type = map['type'];
    _value = map['value'];
  }

  double get value => _value;

  set value(double value) {
    _value = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get category => _category;

  set category(String value) {
    _category = value;
  }

  Map<String, dynamic> toMap() => {
    'category': _category,
    'date': _date,
    'description': _description,
    'type': _type,
    'value': _value
  };

  @override
  String toString() {
    return 'Movement{_category: $_category, _date: $_date, _description: $_description, _type: $_type, _value: $_value}';
  }


}