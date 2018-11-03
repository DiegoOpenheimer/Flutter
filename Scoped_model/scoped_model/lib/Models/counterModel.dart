import 'package:scoped_model/scoped_model.dart';

class CounterModel extends Model {

  int _value = 0;

  int get value => _value;

  void incrementCounter() {
    _value++;
    notifyListeners();
  }

  void decrementCounter() {
    _value--;
    notifyListeners();
  }

}