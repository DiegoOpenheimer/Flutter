import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

enum HandlerTheme {
  dark, light
}

class ThemeBloc extends BlocBase {

  HandlerTheme _hanlderTheme = HandlerTheme.light;
  BehaviorSubject<HandlerTheme> _subject = BehaviorSubject.seeded(HandlerTheme.light);

  Observable<HandlerTheme> get outTheme => _subject.stream;

  void toggleTheme() {
    if (_hanlderTheme == HandlerTheme.light) {
      _hanlderTheme = HandlerTheme.dark;
    } else {
      _hanlderTheme = HandlerTheme.light;
    }
    _subject.add(_hanlderTheme);
  }

  @override
  void dispose() {
    super.dispose();
    _subject.close();
  }

}