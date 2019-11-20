import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/components/CustomNavigationBar.dart';

class TasksWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CustomNavigationBar(title: 'Todo List',),
      child: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    return Stack(
      children: <Widget>[
        Container(),
        Align(
          alignment: Alignment(.9, .75),
          child: FloatingActionButton(
            onPressed: () => Navigator.of(context).pushNamed('/add-todo'),
            child: Icon(CupertinoIcons.add),
            backgroundColor: Colors.lightBlueAccent,
          ),
        )
      ],
    );
  }
}
