

import 'dart:async';
import 'package:pensamentos/services/Configuration.dart';
import 'package:rxdart/rxdart.dart';

class SettingsBloc {

  final Configuration _configuration = Configuration();

  PublishSubject<bool> _controllerSwitch = PublishSubject();
  Stream<bool> get listenerSwitch => _controllerSwitch.stream;

  PublishSubject<double> _controllerSlider = PublishSubject();
  Stream<double> get listenerSlider => _controllerSlider.stream;

  PublishSubject<int> _controllerSegment = PublishSubject();
  Stream<int> get listenerSegment => _controllerSegment.stream;


  Future initialize() async {
    _controllerSwitch.add(await _configuration.automatic);
    _controllerSlider.add(await _configuration.timer);
    _controllerSegment.add(await _configuration.segment);
  }

  void changeSwitch(bool value) {
    _controllerSwitch.add(value);
    _configuration.setAutomatic(value);
  }

  void changeSlider(double value, { bool updateSettings = true }) {
    _controllerSlider.add(value);
    if (updateSettings) {
      _configuration.setTimer(value);
    }
  }

  void changeSegment(int value) {
    _controllerSegment.add(value);
    _configuration.setSegment(value);
  }

  void dispose() {
    _controllerSwitch.close();
    _controllerSlider.close();
    _controllerSegment.close();
  }

}