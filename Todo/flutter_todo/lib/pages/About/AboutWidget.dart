import 'package:flutter/cupertino.dart';
import 'package:flutter_todo/blocs/TaskBloc.dart';
import 'package:flutter_todo/components/CustomNavigationBar.dart';
import 'package:flutter_todo/model/ResultTask.dart';

class AboutWidget extends StatelessWidget {

  final TaskBloc _taskBloc = TaskBloc();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CustomNavigationBar(title: 'About', transitionBetweenRoutes: false,),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    ResultTask resultTask = _taskBloc.calculateResult();
    TextStyle style = TextStyle(
      fontSize: 22,
      color: CupertinoColors.inactiveGray,
    );
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Completed tasks: ${resultTask.completed}', style: style,),
          SizedBox(height: 8,),
          Text('Pending tasks: ${resultTask.pending}', style: style,),
          SizedBox(height: 8,),
          Text('Number of tasks: ${resultTask.numberOfTasks}', style: style,),
        ],
      ),
    );
  }
}
