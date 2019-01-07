import 'dart:async';

class IntroBloc {

  int _initialState = 0;
  int get initialState => _initialState;

  StreamController<int> _streamController = StreamController();

  Sink<int> sink;

  Stream<int> stream;

  IntroBloc() {
    sink = _streamController.sink;
    stream = _streamController.stream.asBroadcastStream();
  }

  void updateIndex(int index) => sink.add(index);

  void close() {
    sink.close();
    _streamController.close();
  }

}