import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:organizze_flutter/Model/Place.dart';
import 'package:organizze_flutter/Model/Trip.dart';
import 'package:organizze_flutter/Repository/TripRepository.dart';

class TripsBloc {

  static final TripsBloc _instance = TripsBloc.internal();
  TripsModel tripsModel;
  TripRepository _tripRepository = TripRepository();

  GoogleMapController _googleMapController;

  StreamController<TripsModel> _streamController;
  Sink<TripsModel> sink;
  Stream<TripsModel> stream;

  TripsBloc.internal() {
    _streamController = StreamController();
    tripsModel = TripsModel();
    stream = _streamController.stream;
    sink = _streamController.sink;
  }

  factory TripsBloc() => _instance;

  void dispose() {
    sink.close();
    _streamController.close();
  }

  void setTrips(List<Trip> trips) {
    print(trips);
    tripsModel.setTrips(trips);
    notifyListeners();
  }

  void addTrip(Trip trip) async {
    tripsModel.trips.add(trip);
    trip.id = await _tripRepository.insertTrip(trip);
    notifyListeners();
  }

  void removeTrip(Trip trip) {
    int index = tripsModel.trips.indexOf(trip);
    if ( index != -1 ) {
      tripsModel.trips.removeAt(index);
      notifyListeners();
      _tripRepository.removeTrip(trip.id);
    }
  }

  void updateTrip(Trip trip) {
    int index = tripsModel.trips.map((Trip t) => t.id).toList().indexOf(trip.id);
    if ( index != -1 ) {
      tripsModel.trips[index] = trip;
      _tripRepository.updateTrip(trip);
      notifyListeners();
    }
  }

  void savePlace(Place place) async {
    Trip trip = tripsModel.trips.firstWhere((Trip t) => t.id == place.idTrip);
    if ( trip != null ) {
      trip.places.add(place);
      trip.price += place.price;
      place.id = await _tripRepository.savePlace(place);
      await _tripRepository.updateTrip(trip);
      notifyListeners();
    }
  }

  void notifyListeners() {
    if ( !_streamController.isClosed ) {
      sink.add(tripsModel);
    }
  }

  void changePositionMap({int index = 0}) {
    if ( _googleMapController != null && tripsModel.trips?.isNotEmpty ) {
      Trip trip = tripsModel.trips[index];
      if ( trip?.places?.isNotEmpty ) {
        double latitude = trip.places[0].latitude;
        double longitude = trip.places[0].longitude;
        _googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(
                CameraPosition(target: LatLng(latitude, longitude), zoom: 10)
            )
        );

      }
    }

  }

  void setGoogleMapController(GoogleMapController googleMapController) => _googleMapController = googleMapController;

}


class TripsModel {
  
  List<Trip> trips = List();
  bool isLoading = false;

  void setTrips(List<Trip> trips) {
    this.trips = trips;
  }


  @override
  String toString() => "TripsModel($isLoading, $trips)";

}