import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/blocs/TaskBloc.dart';
import 'package:flutter_todo/components/Alert.dart';
import 'package:flutter_todo/components/CustomNavigationBar.dart';
import 'package:flutter_todo/services/FlutterToast.dart';
import 'package:meta/meta.dart';

class AddTodoWidget extends StatelessWidget {

  final TextEditingController _controller = TextEditingController();
  final TaskBloc _taskBloc = TaskBloc();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: CupertinoPageScaffold(
        child: _buildBody(context),
        navigationBar: CustomNavigationBar(title: 'Add Todo', previousPageTitle: 'Todo List',),
      ),
    );
  }

  Widget _buildBody(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CupertinoTextField(
            controller: _controller,
            placeholder: 'Register a new todo',
            clearButtonMode: OverlayVisibilityMode.always,
          ),
          SizedBox(height: 32,),
          CupertinoButton.filled(
            padding: EdgeInsets.all(0),
            minSize: 40,
            child: Text('SAVE', style: TextStyle(color: CupertinoColors.white),),
            onPressed: () {
              if (_controller.text.isEmpty) {
                Alert.present(context, message: 'Fill in the field correctly');
              } else {
                _taskBloc.addTask(name: _controller.text)
                .then((T) {
                  FlutterToast.show(message: 'Task added with successfully');
                  Navigator.pop(context);
                })
                .catchError((e) {
                  debugPrint('Fail to register task $e');
                  FlutterToast.show(message: 'Fail to add task');
                });
              }
            }
          ),
        ],
      ),
    );
  }
}
