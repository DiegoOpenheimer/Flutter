import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:organizze_flutter/src/widgets/NewPoint/NewPointBloc.dart';
import 'package:organizze_flutter/src/widgets/NewPoint/NewPointModel.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

class NewPoint extends StatefulWidget {

  int id;

  NewPoint({ @required this.id }) {
    assert(this.id != null);
  }

  @override
  _NewPointState createState() => _NewPointState();
}

class _NewPointState extends State<NewPoint> {
  NewPointBloc _newPointBloc;

  GoogleMapController _googleMapController;

  void initState() {
    _newPointBloc = NewPointBloc();
    _newPointBloc.stream.listen((NewPointModel pointModel) {
      if ( pointModel.canPop ) {
          Navigator.of(context).pop();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _newPointBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          buildHeader(),
          buildContainer()
        ],
      ),
    );
  }

  Widget buildContainer() {
    return Container(
      height: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.height * .6 : 350,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: buildStreamBuilder(),
      ),
    );
  }

  StreamBuilder<NewPointModel> buildStreamBuilder() {
    return StreamBuilder<NewPointModel>(
        stream: _newPointBloc.stream,
        initialData: _newPointBloc.newPointModel,
        builder: (BuildContext context,
            AsyncSnapshot<NewPointModel> snapshot) {
          NewPointModel newPointModel = snapshot.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              buildTextField(
                  hint: 'Nome do ponto',
                  inputType: TextInputType.text,
                  error: newPointModel.validateForm.errorNamePoint,
                  type: 'name',
                  maxLength: 30
              ),
              buildTextField(
                  hint: 'Descrição',
                  inputType: TextInputType.text,
                  error: newPointModel.validateForm.errorDescription,
                  type: 'description',
                  maxLength: 30
              ),
              buildTextField(
                  hint: 'Preço',
                  inputType: TextInputType.number,
                  error: newPointModel.validateForm.errorPrice,
                  type: 'price',
                  maxLength: 10
              ),
              RaisedButton(
                color: Colors.blue,
                onPressed: () => _newPointBloc.savePlace(widget.id),
                child: Text(
                  'Salvar',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          );
        },
      );
  }

  Stack buildHeader() {
    return Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    offset: Offset(0, 1), color: Colors.grey, blurRadius: 0.9)
              ]),
              height: MediaQuery.of(context).size.height * .4,
              child: GoogleMap(
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                    Factory<OneSequenceGestureRecognizer>(
                          () => EagerGestureRecognizer(),
                    ),
                  ].toSet(),
                  options: GoogleMapOptions(
                      cameraPosition: CameraPosition(
                          target: LatLng(37.78825, -122.4324), zoom: 1)),
                  onMapCreated: (GoogleMapController controller) {
                    _googleMapController = controller;
                    _googleMapController.addMarker(MarkerOptions(
                        position: LatLng(37.78825, -122.4324),
                        draggable: true,
                        infoWindowText: InfoWindowText('Pin',
                            'Mova o marcador para definir um ponto para essa viagem ')));
                    _googleMapController.onMarkerDragEnd.add((arguments) {
                      _newPointBloc.setField(
                          'latitude', arguments['latitude']);
                      _newPointBloc.setField(
                          'longitude', arguments['longitude']);
                    });
                  //  _googleMapController.addListener(() => FocusScope.of(context).requestFocus(FocusNode()));
                  }),
            ),
            Positioned(
              left: 10,
              top: 20,
              child: IconButton(
                  color: Colors.white,
                  iconSize: 50,
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () => Navigator.of(context).pop()),
            )
          ],
        );
  }

  TextField buildTextField({String hint, TextInputType inputType, String error, String type, int maxLength}) {
    return TextField(
      onChanged: (String txt) => _newPointBloc.setField(type, txt),
      style: TextStyle(fontSize: 25, color: Colors.black),
      textCapitalization: TextCapitalization.sentences,
      maxLength: maxLength,
      decoration: InputDecoration(
          counterText: '',
          errorText: error,
          hintText: hint,
          hintStyle: TextStyle(fontSize: 25),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(20)),
          fillColor: Colors.black12,
          filled: true,
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(20)),
          border: const OutlineInputBorder()
      ),
      keyboardType: inputType,
    );
  }
}
