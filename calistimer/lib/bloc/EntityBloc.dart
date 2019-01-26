import 'package:calistimer/Model/EntityModel.dart';

class EntityBloc {

  EntityModel _entityModel = EntityModel();

  void setAlert({int index, String value}) {
    _entityModel
    ..hasAlert = index
    ..alert = value;
  }

  void setCountDown({int index}) {
    _entityModel.hasCountDown = index;
  }

  void setMinutes({int minutes}) {
    _entityModel.minutes = minutes ?? 15;
  }

  EntityModel getEntityModel() => _entityModel;

}