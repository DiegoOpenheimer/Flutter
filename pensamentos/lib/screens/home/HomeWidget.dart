import 'package:flutter/cupertino.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBuilder: (_, index) {
        if (index == 1) return Container(color: CupertinoColors.activeOrange,);
        return Container(color: CupertinoColors.activeBlue,);
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
        icon: Icon(CupertinoIcons.gear),
        title: Text('Configurações')
      )
    ];
  }
}
