import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:organizze_flutter/Model/Place.dart';
import 'package:organizze_flutter/Model/Trip.dart';
import 'dart:io';

import 'package:organizze_flutter/src/widgets/NewPoint/NewPoint.dart';
import 'package:organizze_flutter/src/widgets/TripWidget/TripWidgetBloc.dart';

class TripWidget extends StatelessWidget {

  Trip trip;
  TripWidgetBloc _tripWidgetBloc;

  TripWidget({ @required this.trip }) {
    _tripWidgetBloc = TripWidgetBloc();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: buildHeaderStreamBuilder(),
          preferredSize: Size(MediaQuery.of(context).size.width, 200)),
      body: Theme(
          data: ThemeData(accentColor: Colors.lightBlueAccent),
          child: buildBody()),
    );
  }

  StreamBuilder buildHeaderStreamBuilder() {
    return StreamBuilder(
            stream: _tripWidgetBloc.stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return AppBar(flexibleSpace: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(fit: BoxFit.cover, image: trip.img != null ? FileImage(File(trip.img)) : AssetImage('images/background.png'))
                ),
                child: buildInsideAppBar(context),),
              );
            },
          );
  }

  Column buildInsideAppBar(BuildContext context) {
    return Column(
      children: <Widget>[
        buildExpandedAdd(context),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(icon: Icon(Icons.photo_camera), onPressed: () {
                _tripWidgetBloc.selectedImage(trip);
              }, color: Colors.white, iconSize: 50,),
            ),
          ),
        ),
        buildPaddingInformation()
      ],
    );
  }

  Padding buildPaddingInformation() {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(trip.name, style: TextStyle(fontSize: 20),),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: Text('R\$ ${trip.price.toStringAsFixed(2)}', style: TextStyle(color: Colors.white, fontSize: 20),),
            )
          ],
        ),
      );
  }

  Expanded buildExpandedAdd(BuildContext context) {
    return Expanded(
        child: Padding(
          padding: EdgeInsets.only(right: 16, top: 20),
          child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NewPoint(id: this.trip.id,)));
              },
              iconSize: 50,
              color: Colors.white,
              icon: Icon(Icons.add),
            ),
          ),
        ),
      );
  }

  Widget buildBody() {
    return ListView.builder(
      itemCount: trip.places.length,
      itemBuilder: buildItemList,
    );
  }

  Widget buildItemList(BuildContext context, int index) {
    Place place = trip.places[index];
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 0, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${place.name}', style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold),),
                    Text('${place.description}', style: TextStyle(color: Colors.black54, fontSize: 18, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis,)
                  ],
                ),
              ),
              SizedBox(width: 10,),
              SizedBox(
                width: 115,
                child:Text('R\$ ${place.price.toStringAsFixed(2)}', style: TextStyle(color: Colors.blue, fontSize: 18), textAlign: TextAlign.left,)
              )
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}
