

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum ThemeWiched { Dark, Light }

class BlocTheme extends BlocBase {

  ThemeWiched themeWiched = ThemeWiched.Dark;
  final BehaviorSubject<ThemeData> _behaviorSubject = BehaviorSubject.seeded( ThemeData.dark() );
  Observable<ThemeData> get listenerTheme => _behaviorSubject.stream;


  void toggleTheme() {
    ThemeData themeData = _behaviorSubject.value;
    if (themeWiched == ThemeWiched.Dark) {
      themeWiched = ThemeWiched.Light;
      themeData = ThemeData.light();
    } else {
      themeWiched = ThemeWiched.Dark;
      themeData = ThemeData.dark();
    }
    _behaviorSubject.add(themeData);
  }

  ThemeWiched getCurrentTheme() => themeWiched;

}