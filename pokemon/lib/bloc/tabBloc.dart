import 'dart:async';

class TabBloc {

  StreamController<String> streamController = StreamController();

  Stream<String> stream;

  Sink<String> sink;

  TabBloc() {
    stream = streamController.stream;
    sink = streamController.sink;
  }

  void changeTitle(int value) {
    if (value == 0) {
      sink.add('Items');
    } else {
      sink.add('Pokemons');
    }
  }

  void close() {
    sink.close();
    streamController.close();
  }

}