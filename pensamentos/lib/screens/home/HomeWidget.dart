import 'package:flutter/cupertino.dart';
import 'package:pensamentos/screens/mind/MindWidget.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBuilder: (_, index) {
        if (index == 0) return MindWidget();
        return Container(color: CupertinoColors.activeBlue,);
      },
      tabBar: CupertinoTabBar(
        activeColor: Color.fromRGBO(158, 65, 15, 1),
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
