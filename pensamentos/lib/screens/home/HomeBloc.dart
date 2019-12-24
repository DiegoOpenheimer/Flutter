


import 'dart:async';

import 'dart:ui';

import 'package:rxdart/rxdart.dart';

class HomeBloc {

  static HomeBloc _instance = HomeBloc._();

  HomeBloc._();

  factory HomeBloc() => _instance;

  PublishSubject<int> _controller = PublishSubject();
  Stream<int> get listenerTabs => _controller.stream;
  Sink<int> get sink => _controller.sink;

  PublishSubject<AppLifecycleState> _controllerStateApp = PublishSubject();
  Stream<AppLifecycleState> get listenerStateApp => _controllerStateApp.stream;
  Sink<AppLifecycleState> get sinkStateApp => _controllerStateApp.sink;

  void dispose() {
    _controller.close();
    _controllerStateApp.close();
  }

}