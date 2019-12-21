import 'package:flutter/cupertino.dart';
import 'package:pensamentos/screens/home/HomeBloc.dart';
import 'package:pensamentos/screens/mind/MindWidget.dart';
import 'package:flutter/material.dart';
import 'package:pensamentos/screens/settings/SettingsWidget.dart';

class HomeWidget extends StatelessWidget {

  final HomeBloc _homeBloc = HomeBloc();
  final CupertinoTabController _controller = CupertinoTabController();

  HomeWidget() {
    _controller.addListener(() {
      _homeBloc.sink.add(_controller.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: _controller,
      tabBuilder: (_, index) {
        if (index == 0) return MindWidget();
        return SettingsWidget();
      },
      tabBar: CupertinoTabBar(
        items: _buildCupertinoTabs(),
      ),
    );
  }
  
  List<BottomNavigationBarItem> _buildCupertinoTabs() {
    return [
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.book),
        title: Text('Pensamentos'),
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.settings),
        title: Text('Configurações')
      )
    ];
  }
}
