import 'package:calistimer/widgets/Components/Select.dart';
import 'package:flutter/material.dart';
import 'package:calistimer/widgets/Components/Title.dart';

class EmonWidget extends StatefulWidget {

  @override
  EmonWidgetState createState() => EmonWidgetState();

}

class EmonWidgetState extends State<EmonWidget> {

  TextEditingController _textEditingController = TextEditingController(text: '15');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
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
              child: ComponentTitle(title: 'EMON', subTitle: 'Every minutes on the minute', fontSizeTitle: 35,),
            ),
            SizedBox(height: 5,),
            Icon(Icons.watch_later, color: Colors.white, size: 50,),
            SizedBox(height: 30,),
            ComponentSelect(label: 'Alertas', options: ['Desligado', '15s', '30s', '45s'], selected: 0,),
            SizedBox(height: 40,),
            ComponentSelect(label: 'Contagem regressiva', options: ['Sim', 'Não'], selected: 0,),
            SizedBox(height: 40,),
            _chooseMinutes(),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(width: 120,),
                  _buildButtonPlay(),
                  Container(width: 120,child: FlatButton(child: Text('TESTAR', style: TextStyle(fontSize: 20),), onPressed: () {}, textColor: Colors.white,),)
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
        )
      ],
    );
  }

  Widget _buildButtonPlay() {
    return RaisedButton(
      color: Colors.white54,
      padding: EdgeInsets.all(10),
      onPressed: () {},
      child: Icon(Icons.play_arrow, color: Colors.white, size: 40,),
      shape: CircleBorder(),);
  }

}