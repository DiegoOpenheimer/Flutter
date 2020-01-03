import 'package:flutter/material.dart';
import 'package:my_game/screens/consoles/ConsolesWidget.dart';
import 'package:my_game/screens/games/GamesWidget.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.games),
            title: Text('Jogos')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            title: Text('Plataformas')
          ),
        ],
      ),
    );
  }

  Widget _body() {
    if (_currentIndex == 0) {
      return GamesWidget();
    } else {
      return ConsolesWidget();
    }
  }
}
