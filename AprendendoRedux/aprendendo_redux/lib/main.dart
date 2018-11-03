import 'package:aprendendo_redux/SecondPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:aprendendo_redux/reducer/main.dart';
import 'package:redux/redux.dart';
import 'package:aprendendo_redux/reducer/counterReducer.dart';

void main() => runApp(
  StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Apredendo redux',
        theme: ThemeData.dark(),
        home: MyApp(),
      )
  )
);

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('redux'), centerTitle: true,),
      body: buildBody(),
      floatingActionButton: createFloatingAction(),
    );
  }


  Widget buildBody() {
    return Center(
      child: StoreConnector<AppState, int>(
          builder: (BuildContext context, int counter) => GestureDetector(
            child: Text('Contador $counter'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SecondPage())),
          ),
          converter: (Store store) => store.state.value
      ),
    );
  }

  Widget createFloatingAction() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: const Alignment(-.83, 1.0),
          child: StoreConnector<AppState, VoidCallback>(
              builder: (BuildContext context, VoidCallback callback) =>
              FloatingActionButton(child: const Icon(Icons.remove), onPressed: callback, heroTag: 'btn1',),
              converter: (Store store) => () => store.dispatch(DecrementAction(1))
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: StoreConnector<AppState, VoidCallback>(
              builder: (BuildContext context, VoidCallback callback) =>
              FloatingActionButton(child: const Icon(Icons.add), onPressed: callback, heroTag: 'btn2',),
              converter: (Store store) => () => store.dispatch(IncrementAction(1))
          ),
        )
      ],
    );
  }

}