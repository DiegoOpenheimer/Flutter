import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/blocs/TaskBloc.dart';
import 'package:flutter_todo/components/Alert.dart';
import 'package:flutter_todo/components/CheckBoxiOS.dart';
import 'package:flutter_todo/components/CustomNavigationBar.dart';
import 'package:flutter_todo/model/Task.dart';
import 'package:flutter_todo/services/FlutterToast.dart';

class TasksWidget extends StatefulWidget {

  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  
  final TaskBloc _taskBloc = TaskBloc();
  final ScrollController _scrollController = ScrollController();
  
  @override
  void initState() {
    super.initState();
    _taskBloc.init();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CustomNavigationBar(title: 'Todo List',),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            _buildSegment(),
            Expanded(child: _buildList()),
          ],
        ),
        Align(
          alignment: Alignment(.9, .75),
          child: FloatingActionButton(
            onPressed: () async {
              await Navigator.of(context).pushNamed('/add-todo');
              await Future.delayed(Duration(milliseconds: 50));
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut
              );
            },
            child: Icon(CupertinoIcons.add),
            backgroundColor: Color(0xff00dec4),
          ),
        )
      ],
    );
  }

  Widget _buildSegment() {
    return Center(
      child: StreamBuilder<int>(
        stream: _taskBloc.segmentStream,
        initialData: 0,
        builder: (context, snapshot) {
          return CupertinoSegmentedControl<int>(
            padding: const EdgeInsets.all(16),
            onValueChanged: (int value) => _taskBloc.changeSegment(value),
            groupValue: snapshot.data,
            children: <int, Widget>{
              0: Padding(child: Text('All'), padding: const EdgeInsets.symmetric(horizontal: 8),),
              1: Padding(child: Text('Todo'), padding: const EdgeInsets.symmetric(horizontal: 8),),
              2: Padding(child: Text('Complete'), padding: const EdgeInsets.symmetric(horizontal: 8),)
            },
          );
        }
      ),
    );
  }

  Widget _buildList() {
    return StreamBuilder<List<Task>>(
      stream: _taskBloc.taskStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
        List tasks = snapshot.data;
        if (tasks.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _taskBloc.currentSegment == 0 || _taskBloc.tasks.isEmpty ? CupertinoButton(
                child: Icon(CupertinoIcons.add_circled, color: CupertinoColors.activeBlue, size: 28,),
                onPressed: () => Navigator.pushNamed(context, '/add-todo'),
              ) : Container(),
              Text('No task registered', style: TextStyle(fontSize: 20),),
              SizedBox(height: 110,)
            ],
          );
        }
        return ListView.separated(
          controller: _scrollController,
          separatorBuilder: (c, i) => Divider(color: CupertinoColors.inactiveGray, height: 1,),
          itemCount: tasks.length,
          itemBuilder: (context, index) => _buildItem(tasks[index]),
        );
      },
    );
  }

  Widget _buildItem(Task task) {
    TextStyle style = task.complete ?
    TextStyle(decoration: TextDecoration.lineThrough) :
    TextStyle();
    Color color = task.complete ? CupertinoColors.lightBackgroundGray : Colors.transparent;
    return Material(
      color: color,
      child: InkWell(
        onLongPress: () => removeTask(task),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    CheckBoxiOS(checked: task.complete, onChanged: (value) {
                      _taskBloc.updateStatus(task..complete = value);
                    },),
                    SizedBox(width: 16,),
                    Flexible(child: Text(task.name, overflow: TextOverflow.ellipsis, maxLines: 2, style: style,))
                  ],
                ),
              ),
              CupertinoButton(
                onPressed: () => removeTask(task),
                child: Icon(CupertinoIcons.delete, color: CupertinoColors.destructiveRed, size: 35),
              )
            ],
          ),
        ),
      ),
    );
  }

  void removeTask(Task task) {
    Alert.presentWithOptions(
        context,
        callbackOK: () async {
          try {
            _taskBloc.remove(task);
            FlutterToast.show(message: 'Task removed with successfully');
          } catch(e) {
            FlutterToast.show(message: 'Fail to remove task');
          } finally {
            Navigator.of(context).pop();
          }
        },
        message: 'Do you really want to delete the task ${task.name}'
    );
  }
}
