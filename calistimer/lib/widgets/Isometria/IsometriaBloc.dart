import 'package:calistimer/Model/IsometriaModel.dart';

class IsometriaBloc {

  IsometriaModel _isometriaModel = IsometriaModel();

  IsometriaModel getIsometriaModel() => _isometriaModel;

  void setGoal({int index, String goal}) {
    _isometriaModel
      ..goal = goal
      ..hasGoal = index;
  }

  void setSeconds({int seconds}) {
    _isometriaModel.seconds = seconds;
  }

}