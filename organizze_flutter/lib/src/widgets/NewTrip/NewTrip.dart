import 'dart:io';
import 'package:flutter/material.dart';
import 'package:organizze_flutter/src/widgets/NewTrip/NewTripBloc.dart';
import 'package:organizze_flutter/src/widgets/NewTrip/NewTripModel.dart';


class NewTrip extends StatefulWidget {

  @override
  NewTripState createState() => NewTripState();

}

class NewTripState extends State<NewTrip> {

  File _image;
  NewTripBloc _newTripBloc;

  @override
  void initState() {
    _newTripBloc = NewTripBloc();
    _newTripBloc.stream.listen((NewTripModel tripModel) {
      if ( tripModel.goBackPage ) {
        Navigator.of(context).pop();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _newTripBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: PreferredSize(
            child: buildAppBar(),
            preferredSize: Size(MediaQuery.of(context).size.width, 200)),
        body: body(),
      ),
    );
  }

  StreamBuilder<NewTripModel> buildAppBar() {
    return StreamBuilder<NewTripModel>(
      stream: _newTripBloc.stream,
      initialData: _newTripBloc.newTripModel,
      builder: (BuildContext context, AsyncSnapshot<NewTripModel> snapshot) {
        NewTripModel tripModel = snapshot.data;
        return AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(image: DecorationImage(image: tripModel.image != null ? FileImage(tripModel.image) : AssetImage('images/background.png'), fit: BoxFit.cover)),
            child: Align(
              alignment: tripModel.image == null ? Alignment.center : Alignment(1, -.7),
              child: IconButton(
                  iconSize: tripModel.image == null ? 80 : 40,
                  color: Colors.white,
                  icon: Icon(Icons.photo_camera),
                  onPressed: () => _newTripBloc.selectedPicture()),
            ),
          ),
        );
      },
    );
  }

  Padding body() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('Nova Viagem', style: TextStyle(color: Colors.blueGrey, fontSize: 30), textAlign: TextAlign.center,),
          SizedBox(height: 20,),
          streamBuilderTextField(),
          SizedBox(height: 20,),
          RaisedButton(
            onPressed: () => _newTripBloc.saveTrip(),
            color: Colors.blue,
            textColor: Colors.white,
            child: Text('Salvar', style: TextStyle(fontSize: 20),),
          )
        ],
      ),
    );
  }

  StreamBuilder<NewTripModel> streamBuilderTextField() {
    return StreamBuilder<NewTripModel>(
          stream: _newTripBloc.stream,
          initialData: _newTripBloc.newTripModel,
          builder: (BuildContext context, AsyncSnapshot<NewTripModel> snapshot) {
              NewTripModel tripModel = snapshot.data;
              return TextField(
                onChanged: (String txt) => _newTripBloc.setText(txt),
                style: TextStyle(fontSize: 20, color: Colors.black),
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                    errorText: tripModel.message,
                    hintText: 'Informe o nome',
                    hintStyle: TextStyle(fontSize: 20),
                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(20)),
                    fillColor: Colors.black12,
                    filled: true,
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(20)),
                    border: const OutlineInputBorder()
                ),
              );
          },
        );
  }
}
