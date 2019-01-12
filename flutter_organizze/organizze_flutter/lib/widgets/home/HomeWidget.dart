import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:organizze_flutter/widgets/home/HomeBloc.dart';
import 'package:organizze_flutter/widgets/home/HomeModel.dart';
import 'package:organizze_flutter/widgets/home/components/CalenderWidget.dart';
import 'package:organizze_flutter/widgets/home/components/FabButton.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  HomeBloc _homeBloc;
  FabButtonWidget _fabButtonWidget;
  PageController _pageController = PageController(initialPage: DateTime.now().month - 1);

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.black.withOpacity(0.1)
    ));
    _fabButtonWidget = FabButtonWidget();
    _homeBloc = HomeBloc();
    _homeBloc.addListenerAuthOnChange();
    _homeBloc.listenMovements();
    listenBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _homeBloc.close();
  }

  void listenBloc() {
    _homeBloc.stream.listen((HomeModel homeModel) {
        if ( !homeModel.userIsConnected ) {
          Navigator.of(context).pushReplacementNamed('/');
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_fabButtonWidget.isOpen()) {
          _fabButtonWidget.handlerButton();
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: GestureDetector(
        onTap: () {
          if (_fabButtonWidget.isOpen()) {
            _fabButtonWidget.handlerButton();
          }
        },
        child: Scaffold(
          floatingActionButton: _fabButtonWidget,
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          body: Scaffold(
            body: buildBody(),
          ),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: <Widget>[
        buildContainerHeader(),
        CalendarWidget(_homeBloc)
      ],
    );
  }

  Container buildContainerHeader() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: [BoxShadow(
            color: Colors.black45,
            blurRadius: 10,
            offset: Offset(0, 2)
          )]
        ),
        height: 300,
        child: Stack(
          children: <Widget>[
            PopupMenu()
          ],
        ),
      );
  }

  Positioned PopupMenu() {
    return Positioned(
            top: 16,
            right: 0,
            child: PopupMenuButton<int>(
                onSelected: (int value) {
                  _homeBloc.signOut();
                },
                padding: EdgeInsets.all(0),
                itemBuilder: (context) {
                  return <PopupMenuEntry<int>>[
                    PopupMenuItem<int>(
                      value: 0,
                      child: Text('Sair'),
                    )
                  ];
                },
            ),
          );
  }
}
