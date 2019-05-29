import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../BlocIncrement.dart';
import '../BlocTheme.dart';

class HomeWidget extends StatelessWidget {

  BlocTheme bloc = BlocProvider.getBloc<BlocTheme>();
  BlocIncrement blocIncrement = BlocProvider.getBloc<BlocIncrement>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Bloc pattern'), centerTitle: true, actions: <Widget>[
        IconButton(icon: Icon(Icons.track_changes), onPressed: bloc.toggleTheme,)
      ],),
      body: _body(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          blocIncrement.increment(1);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _body(context) {
    print('BODY');
    return FractionallySizedBox(
      widthFactor: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _responsibleCounter(),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/messages');
            },
            child: Text('Messages',),
          )
        ],
      ),
    );
  }

  Widget _responsibleCounter() {
    return StreamBuilder(
      stream: blocIncrement.outIncrement,
      builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
        String value = asyncSnapshot.data.toString();
        return Text( value, textAlign: TextAlign.center );
      },
    );
  }
}
