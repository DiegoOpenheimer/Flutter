import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:organizze_flutter/Model/Trip.dart';
import 'package:organizze_flutter/src/widgets/NewTrip/NewTrip.dart';
import 'package:organizze_flutter/src/widgets/TripWidget/TripWidget.dart';
import 'package:organizze_flutter/Bloc/TripsBloc.dart';

class TripsWidgets extends StatelessWidget {

  TripsBloc _tripsBloc = TripsBloc();
  GoogleMapController _googleMapController;
  ScrollController _scrollController = ScrollController();

  TripsWidgets() {
    FlutterStatusbarManager.setColor(Colors.black.withOpacity(0.2),
        animated: true);
    FlutterStatusbarManager.setStyle(StatusBarStyle.LIGHT_CONTENT);
    _scrollController.addListener(() {
      double viewport = double.parse(_scrollController.position.viewportDimension.toStringAsFixed(1));
      double offset = double.parse(_scrollController.offset.toStringAsFixed(1));
     if ( (offset % viewport).toInt() == 0 ) {
        int result = offset~/viewport;
        _tripsBloc.changePositionMap(index: result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return StreamBuilder<TripsModel>(
      initialData: _tripsBloc.tripsModel,
      stream: _tripsBloc.stream,
      builder: (BuildContext context, AsyncSnapshot<TripsModel> snapshot) {
        return Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  GoogleMap(
                    onMapCreated: (GoogleMapController googleMapController) {
                       _googleMapController = googleMapController;
                       _tripsBloc.setGoogleMapController(googleMapController);
                       _tripsBloc.changePositionMap();
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NewTrip()));
                      },
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.add),
                      ),
                    ),
                  )
                ],
              ),
            ),
            snapshot.data.trips.isNotEmpty ? buildSpaceList(snapshot.data.trips) : null
          ].where((Widget widget) => widget != null).toList(),
        );
      },
    );
  }

  Container buildSpaceList(List<Trip> trips) {
    return Container(
      height: 200,
      decoration: BoxDecoration(color: Colors.white),
      child: Theme(
          data: ThemeData(accentColor: Colors.blue),
          child: ListView.builder(
              controller: _scrollController,
              physics: PageScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(0),
              itemCount: trips.length,
              itemBuilder: (context, index) {
                return buildItemList(context, index, trips);
              })),
    );
  }

  Widget buildItemList(BuildContext context, int index, List<Trip> trips) {
    Trip trip = trips[index];
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildContainer(context, trip),
          Text(
            trip.name,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
          )
        ],
      ),
    );
  }

  Widget buildContainer(BuildContext context, Trip trip) {
    return GestureDetector(
      onLongPress: () { showAlert(context, trip); },
      child: Container(
        decoration: checkImgToContainers(trip),
        height: 148,
        width: MediaQuery.of(context).size.width - 32,
        child: buildMaterial(context, trip),
      ),
    );
  }

  void showAlert(BuildContext context, Trip trip) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text('Atenção'),
            content: Text('Deseja mesmo remover essa viagem?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Não', style: TextStyle(fontSize: 20)),
                onPressed: () { Navigator.of(context).pop(); },
              ),
              FlatButton(
                child: Text('Sim', style: TextStyle(fontSize: 20),),
                onPressed: () {
                  Navigator.of(context).pop();
                  _tripsBloc.removeTrip(trip);
                },
              )
            ],
          );
        }
    );
  }

  Material buildMaterial(BuildContext context, Trip trip) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.white24,
        highlightColor: Colors.white30,
        onTap: (){goTripView(context, trip);},
        child: Stack(
        children: <Widget>[
          checkImgToRenderInContainer(trip),
          Padding(
            padding: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'R\$ ${trip.price.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],),
      ),
    );
  }

  Center checkImgToRenderInContainer(Trip trip) {
    if (trip.img != null) {
      return Center();
    }
    return Center(child: Image.asset('images/trip.png', fit: BoxFit.contain, height: 100, width: 100,));
  }

  BoxDecoration checkImgToContainers(Trip trip) {
    if (trip.img != null) {
      return BoxDecoration(
          image: DecorationImage(
              image: FileImage(File(trip.img)), fit: BoxFit.cover));
    }
    return BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/background.png'), fit: BoxFit.cover));
  }

  void goTripView(BuildContext context, Trip trip) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TripWidget(
                  trip: trip,
                )));
  }
}
