import 'package:organizze_flutter/Model/Place.dart';

class NewPointModel {

  Place place;
  _ValidateForm validateForm;
  bool canPop = false;

  NewPointModel() :
    place = Place( latitude: 37.78825, longitude: -122.4324 ),
    validateForm = _ValidateForm();

  bool validateInputs() {
    return validateForm.validateFields(place);
  }

  @override
  String toString() {
    return 'NewPointModel{place: $place, validateForm: $validateForm, canPop: $canPop}';
  }


}


class _ValidateForm {

  String _errorNamePoint;
  String _errorDescription;
  String _errorPrice;

  _ValidateForm();

  String get errorPrice => _errorPrice;

  set errorPrice(String value) {
    _errorPrice = value;
  }

  String get errorDescription => _errorDescription;

  set errorDescription(String value) {
    _errorDescription = value;
  }

  String get errorNamePoint => _errorNamePoint;

  set errorNamePoint(String value) {
    _errorNamePoint = value;
  }

  bool validateFields(Place place) {
    assert(place != null, 'place can\'t be null');
    bool result = true;
    if ( place.name == null || place.name.isEmpty ) {
      result = false;
      errorNamePoint = "Campo obrigatório";
    }
    if ( place.description == null || place.description.isEmpty ) {
      result = false;
      errorDescription = "Campo obrigatório";
    }
    if ( place.price == null ) {
      result = false;
      errorPrice = "Campo obrigatório";
    }
    return result;
  }

  @override
  String toString() {
    return 'NewPointModel{_errorNamePoint: $_errorNamePoint, _errorDescription: $_errorDescription, _errorPrice: $_errorPrice}';
  }

}