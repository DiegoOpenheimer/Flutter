import 'package:calistimer/bloc/EntityBloc.dart';
import 'package:calistimer/widgets/Amrap/AmrapRunning/AmrapWidgetRunning.dart';
import 'package:calistimer/widgets/Components/Select.dart';
import 'package:calistimer/widgets/Emon/EmonRunning/EmonRunningWidget.dart';
import 'package:flutter/material.dart';
import 'package:calistimer/widgets/Components/Title.dart';

class AmrapWidget extends StatefulWidget {

  @override
  AmrapWidgetState createState() => AmrapWidgetState();

}

class AmrapWidgetState extends State<AmrapWidget> {

  TextEditingController _textEditingController = TextEditingController();
  EntityBloc _entityBloc;

  @override
  void initState() {
    super.initState();
    _entityBloc = EntityBloc();
    _textEditingController.text = _entityBloc.getEntityModel().minutes.toString();
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
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 80),
              child: ComponentTitle(title: 'Amrap', fontSizeTitle: 35,),
            ),
            SizedBox(height: 5,),
            Icon(Icons.watch_later, color: Colors.white, size: 50,),
            SizedBox(height: 30,),
            ComponentSelect(label: 'Alertas', options: ['Desligado', '15s', '30s', '45s'], selected: _entityBloc.getEntityModel().hasAlert, onSelected: (int index, String value) {
              _entityBloc.setAlert(index: index, value: value);
            },),
            SizedBox(height: 40,),
            ComponentSelect(label: 'Contagem regressiva', options: ['Não', 'Sim'], selected: _entityBloc.getEntityModel().hasCountDown, onSelected: (int index, String value) => _entityBloc.setCountDown(index: index),),
            SizedBox(height: 40,),
            _chooseMinutes(),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(width: 120,),
                  _buildButtonPlay(),
                  Container(width: 120,child: FlatButton(child: Text('TESTAR', style: TextStyle(fontSize: 20),), onPressed: () {
                    play(duration: const Duration(milliseconds: 100));
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
      children: <Widget>[
        Text('Quantos minutos', style: TextStyle(color: Colors.white, fontSize: 20),),
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
          onChanged: (String minute) => _entityBloc.setMinutes(minutes: int.tryParse(minute)),
        )
      ],
    );
  }

  Widget _buildButtonPlay() {
    return RaisedButton(
      color: Colors.white54,
      padding: EdgeInsets.all(10),
      onPressed: () {
        play(duration: const Duration(seconds: 1));
      },
      child: Icon(Icons.play_arrow, color: Colors.white, size: 40,),
      shape: CircleBorder(),);
  }

  void play({ Duration duration }) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> a1, Animation<double> a2) => AmrapRunningWidget(_entityBloc.getEntityModel(), duration: duration,),
      transitionDuration: const Duration(milliseconds: 1)
    ));
  }

}