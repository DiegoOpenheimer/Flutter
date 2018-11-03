import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:learn_scoped_model/Models/counterModel.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second Page'), centerTitle: true,),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return ScopedModelDescendant<CounterModel>(
      builder: (BuildContext context, Widget child, CounterModel model) {
        return Center(
          child: Text('Contador ${model.value}'),
        );
      },
    );
  }
}
