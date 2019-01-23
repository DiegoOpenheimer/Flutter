import 'package:calistimer/widgets/Components/Select.dart';
import 'package:calistimer/widgets/Isometria/IsometriaBloc.dart';
import 'package:calistimer/widgets/Isometria/IsometriaRunning/IsometriaRunningWidget.dart';
import 'package:flutter/material.dart';
import 'package:calistimer/widgets/Components/Title.dart';

class IsometriaWidget extends StatefulWidget {

  @override
  IsometriaWidgetState createState() => IsometriaWidgetState();

}

class IsometriaWidgetState extends State<IsometriaWidget> {

  TextEditingController _textEditingController = TextEditingController();
  IsometriaBloc _isometriaBloc;

  @override
  void initState() {
    super.initState();
    _isometriaBloc = IsometriaBloc();
    _textEditingController.text = _isometriaBloc.getIsometriaModel().seconds.toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xFFD6304A),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 80),
              child: ComponentTitle(title: 'Isometria', fontSizeTitle: 35,),
            ),
            SizedBox(height: 5,),
            Icon(Icons.watch_later, color: Colors.white, size: 50,),
            SizedBox(height: 40,),
            ComponentSelect(label: 'Objetivo', options: ['Livre', 'Bater tempo'], selected: _isometriaBloc.getIsometriaModel().hasGoal, onSelected: (int index, String value) {
              _isometriaBloc.setGoal(index: index, goal: value);
            },),
            SizedBox(height: 40,),
            _chooseMinutes(),
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(width: 120,),
                  _buildButtonPlay(),
                  Container(width: 120,child: FlatButton(child: Text('TESTAR', style: TextStyle(fontSize: 20),), onPressed: () {
                    _goRunning(const Duration(milliseconds: 100));
                  }, textColor: Colors.white,),)
                ],
              ),
            )
          ],
        ),
      ),

    );
  }

  Widget _chooseMinutes() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Quantos segundos', style: TextStyle(color: Colors.white, fontSize: 20),),
        TextField(
          controller: _textEditingController,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            counterText: '',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(0),
          ),
          style: TextStyle(fontSize: 96, color: Colors.white),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 4,
          onChanged: (String second) {
            _isometriaBloc.setSeconds(seconds: int.tryParse(second));
          },
        )
      ],
    );
  }

  Widget _buildButtonPlay() {
    return RaisedButton(
      color: Colors.white54,
      padding: EdgeInsets.all(10),
      onPressed: () => _goRunning(const Duration(seconds: 1)),
      child: Icon(Icons.play_arrow, color: Colors.white, size: 40,),
      shape: CircleBorder(),);
  }

  void _goRunning(Duration duration) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
          return IsometriaRunningWidget(_isometriaBloc.getIsometriaModel(), duration: duration,);
        },
        transitionDuration: const Duration(milliseconds: 1)
      )
    );
  }

}