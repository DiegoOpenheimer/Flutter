import 'package:flutter/material.dart';
import 'package:organizze_flutter/Repository/TripRepository.dart';
import 'package:organizze_flutter/src/widgets/HomeWidget.dart';
import 'package:organizze_flutter/Bloc/TripsBloc.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  MyApp() {
    initialize();
  }

  void initialize() async {
    TripRepository tripRepository = TripRepository();
    await tripRepository.open();
    TripsBloc().setTrips(await tripRepository.getTrips());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Trip",
      home: HomeWidget(),
    );
  }

}