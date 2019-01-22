import 'package:calistimer/Model/EmonModel.dart';

class EmonBloc {

  EmonModel _emonModel = EmonModel();

  void setAlert({int index, String value}) {
    _emonModel
    ..hasAlert = index
    ..alert = value;
  }

  void setCountDown({int index}) {
    _emonModel.hasCountDown = index;
  }

  void setMinutes({int minutes}) {
    _emonModel.minutes = minutes ?? 15;
  }

  EmonModel getEmonModel() => _emonModel;

}