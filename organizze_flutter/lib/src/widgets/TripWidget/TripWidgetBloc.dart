import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:organizze_flutter/Bloc/TripsBloc.dart';
import 'package:organizze_flutter/Model/Trip.dart';

class TripWidgetBloc {
  String _imagePath;

  get imagePath => _imagePath;

  StreamController _streamController = StreamController();

  Sink sink;

  Stream stream;

  TripWidgetBloc() {
    sink = _streamController.sink;
    stream = _streamController.stream;
  }

  void close() {
    sink.close();
    _streamController.close();
  }

  void selectedImage(Trip trip) async {
    try {
      File image = await ImagePicker.pickImage(source: ImageSource.gallery);
      if ( image != null ) {
        trip.img = image.path;
        TripsBloc tripsBloc = TripsBloc();
        tripsBloc.updateTrip(trip);
        sink.add(null);
      }
    } catch( e ) {
      print('ERROR: $e');
    }
  }
}
