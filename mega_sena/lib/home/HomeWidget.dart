import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:mega_sena/create_game/CreateGame.dart';
import 'package:mega_sena/list_games/ListGame.dart';
import 'package:mega_sena/shared/components/MegaSenaContainer.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(context) {
    return MegaSenaContainer(
      child: Scaffold(
        body: _body(),
        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.flip,
          controller: _tabController,
          backgroundColor: Theme.of(context).primaryColor,
          items: [
            TabItem(
              icon: Icon(
                Icons.games_outlined,
                color: Colors.white,
              ),
              title: 'Jogos',
            ),
            TabItem(
              icon: Icon(
                Icons.create,
                color: Colors.white,
              ),
              title: 'Registrar',
            ),
          ],
          onTap: (index) {
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.decelerate);
          },
        ),
      ),
    );
  }

  Widget _body() {
    return PageView(
      // physics: NeverScrollableScrollPhysics(),
      onPageChanged: (int page) {
        _tabController?.animateTo(page);
      },
      controller: _pageController,
      children: [
        ListGame(
          pageController: _pageController,
        ),
        CreateGame()
      ],
    );
  }
}
