
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class BlocIncrement extends BlocBase {

  int counter = 0;

  final BehaviorSubject<int> _subject = BehaviorSubject.seeded( 0 );

  Observable<int> get outIncrement => _subject.stream;

  void increment(int value) {
    counter += value;
    _subject.add( counter );
  }


  @override
  void dispose() {
    _subject.close();
  }


}