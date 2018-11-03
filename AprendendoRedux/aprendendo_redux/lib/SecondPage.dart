import 'package:aprendendo_redux/reducer/main.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second'), centerTitle: true,),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Center(
      child: StoreConnector<AppState, int>(
          builder: (BuildContext context, int value) =>
          Text('Contador $value'),
          converter: (Store store) => store.state.value
      ),
    );
  }
}
