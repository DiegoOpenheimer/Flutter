import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:organizze_flutter/Bloc/TripsBloc.dart';
import 'package:organizze_flutter/Model/Trip.dart';
import 'package:organizze_flutter/src/widgets/NewTrip/NewTripModel.dart';
import 'dart:io';

class NewTripBloc {

  NewTripModel newTripModel = NewTripModel();

  String nameTrip;

  StreamController<NewTripModel> _streamController = StreamController();

  Sink<NewTripModel> _sink;

  Stream<NewTripModel> _stream;

  Sink<NewTripModel> get sink => _sink;

  Stream<NewTripModel> get stream => _stream;

  NewTripBloc() {
    _sink = _streamController.sink;
    _stream = _streamController.stream.asBroadcastStream();
  }

  void close() {
    _streamController.close();
    _sink.close();
  }

  void saveTrip() {
    if (nameTrip == null || nameTrip.isEmpty) {
      newTripModel.message = 'Campo Obrigatório';
      sink.add(newTripModel);
    } else {
      String path = newTripModel.image != null ? newTripModel.image.path : null;
      Trip trip = Trip(name: nameTrip, price: 0, img: path);
      TripsBloc tripsBloc = TripsBloc();
      tripsBloc.addTrip(trip);
      sink.add(newTripModel..goBackPage = true);
    }
  }

  void setText(String txt) {
    nameTrip = txt;
    sink.add(newTripModel..message = null);
  }

  void selectedPicture() async {
    try {
      File image = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        sink.add(newTripModel..image = image);
      }
    } catch(e) {
      print('ERROR TO SELECTED IMAGE $e');
    }
  }

}