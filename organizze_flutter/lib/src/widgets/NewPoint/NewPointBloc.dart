import 'dart:async';
import 'package:organizze_flutter/Bloc/TripsBloc.dart';
import 'package:organizze_flutter/src/widgets/NewPoint/NewPointModel.dart';

class NewPointBloc {

  NewPointModel _newPointModel = NewPointModel();
  get newPointModel => _newPointModel;

  StreamController<NewPointModel> _streamController = StreamController();

  Sink<NewPointModel> sink;

  Stream<NewPointModel> stream;

  NewPointBloc() {
    sink = _streamController.sink;
    stream = _streamController.stream.asBroadcastStream();
  }

  void close() {
    sink.close();
    _streamController.close();
  }

  void savePlace(int id) {
    bool result = _newPointModel.validateInputs();
    if ( result ) {
      final TripsBloc tripsBloc = TripsBloc();
      _newPointModel.place.idTrip = id;
      tripsBloc.savePlace(_newPointModel.place);
      _newPointModel.canPop = true;
      sink.add( _newPointModel );
    } else {
      sink.add(newPointModel);
    }
  }

  void setField(String type, var content) {
    switch( type ) {
      case 'name':
        if ( content.toString().isNotEmpty ) {
          _newPointModel.validateForm.errorNamePoint = null;
        }
        _newPointModel.place.name = content.toString();
        break;
      case 'description':
        if ( content.toString().isNotEmpty ) {
          _newPointModel.validateForm.errorDescription = null;
        }
        _newPointModel.place.description = content.toString();
        break;
      case 'price':
        if ( content != null || content.toString().isNotEmpty ) {
          _newPointModel.validateForm.errorPrice = null;
        }
        _newPointModel.place.price = double.parse(content);
        break;
      case 'latitude':
        _newPointModel.place.latitude = content;
        break;
      case 'longitude':
        _newPointModel.place.longitude = content;
        break;
    }
     sink.add(newPointModel);
  }

}