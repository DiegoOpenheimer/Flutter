import 'package:flutter/material.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'dart:math';

import 'package:organizze_flutter/src/widgets/TripsWidgets/TripsWidgets.dart';

class HomeWidget extends StatefulWidget {

  @override
  HomeWidgetState createState() => HomeWidgetState();

}

class HomeWidgetState extends State<HomeWidget> {

  int step = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
    );
  }

  @override
  void initState() {
    FlutterStatusbarManager.setColor(Colors.black.withOpacity(0.2), animated: true);
    super.initState();
  }


  Widget buildBody(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("images/background.png"), fit: BoxFit.cover),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 100),
            height: 150,
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/trip.png'), fit: BoxFit.contain)),
          ),
          Expanded(child: Container(),),
          Image.asset('images/LOGO.png', height: 50,),
          SizedBox(height: 30),
          changeComponentBottom(context),
        ],
      ),
    );
  }

  Widget changeComponentBottom(BuildContext context) {
    return AnimatedCrossFade(
      sizeCurve: Curves.decelerate,
      duration: Duration(milliseconds: 500),
      crossFadeState: step == 0 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: buildBtnBottom(),
      secondChild: buildBtnStepEmpty(context),
    );
  }

  Material buildBtnBottom() {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () { setState(() => step = 1); },
        child: Container(
          alignment: Alignment.center,
          height: 50,
          child: Text("COMEÇAR", style: const TextStyle(fontSize: 18, color: Colors.black),),
        ),
      ),
    );
  }

  Container buildBtnStepEmpty(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20,),
          Image.asset('images/pin.png', height: 80, width: 80, fit: BoxFit.contain),
          SizedBox(height: 10,),
          Text('Vamos planejar sua \nprimeira viagem?', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.center,),
          SizedBox(height: 10,),
          Material(
            color: Colors.white,
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                goTripsView(context);
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.arrow_forward, color: Colors.black, size: 40),
              ),
            ),
          )
        ],
      ),
    );
  }

  void goTripsView(BuildContext context) {
      Navigator.pushReplacement(context, PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 0),
          pageBuilder: (context, animation1, animation2) {
              return TripsWidgets();
        }));
  }

}
