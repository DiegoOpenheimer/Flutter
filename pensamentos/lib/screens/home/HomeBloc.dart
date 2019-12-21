


import 'dart:async';

class HomeBloc {

  static HomeBloc _instance = HomeBloc._();

  HomeBloc._();

  factory HomeBloc() => _instance;

  StreamController<int> _controller = StreamController();
  Stream<int> get listenerTabs => _controller.stream;
  Sink<int> get sink => _controller.sink;

  void dispose() {
    _controller.close();
  }

}