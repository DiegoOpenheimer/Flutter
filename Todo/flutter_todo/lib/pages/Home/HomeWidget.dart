import 'package:flutter/cupertino.dart';
import 'package:flutter_todo/pages/About/AboutWidget.dart';
import 'package:flutter_todo/pages/Tasks/TasksWidget.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: _buildItems(),
      ),
      tabBuilder: (BuildContext context, int index) {
        if (index == 0) return TasksWidget();
        if (index == 1) return AboutWidget();
        return null;
      },
    );
  }

  List<BottomNavigationBarItem> _buildItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.bookmark_solid),
        title: Text('Tasks')
      ),
      BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.info),
          title: Text('About')
      )
    ];
  }
}
