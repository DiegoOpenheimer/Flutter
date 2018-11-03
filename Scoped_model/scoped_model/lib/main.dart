import 'package:flutter/material.dart';
import 'package:learn_scoped_model/SecondPage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:learn_scoped_model/Models/counterModel.dart';

void main() => runApp(
    ScopedModel<CounterModel>(
        model: CounterModel(),
        child: MaterialApp(
          title: 'Aprendendo scoped model',
          theme: ThemeData.dark(),
          home: MyApp(),
        )
    )
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scoped Model'), centerTitle: true,),
      body: buildBody(),
      floatingActionButton: buildFloatingAction(),
    );
  }

  Widget buildBody() {
    return ScopedModelDescendant<CounterModel>(
      builder: (BuildContext context, Widget child, CounterModel model) {
        return Center(
          child: GestureDetector(
            child: Text('Contador ${model.value}'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SecondPage())),
          ),
        );
      },
    );
  }

  Widget buildFloatingAction() {
    return ScopedModelDescendant<CounterModel>(
      builder: (BuildContext context, Widget child, CounterModel model) {
        return Stack(
          children: <Widget>[
            Align(
              alignment: Alignment(-.83, 1.0),
              child: FloatingActionButton(child: const Icon(Icons.remove), onPressed: model.decrementCounter, heroTag: 'btn1',),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(child: Icon(Icons.add), onPressed: model.incrementCounter, heroTag: 'btn2'),
            )
          ],
        );
      },
    );
  }
}

