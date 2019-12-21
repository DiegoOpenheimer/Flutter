

import 'dart:async';

import 'package:pensamentos/services/Configuration.dart';

class SettingsBloc {

  final Configuration _configuration = Configuration();

  StreamController<bool> _controllerSwitch = StreamController();
  Stream<bool> get listenerSwitch => _controllerSwitch.stream;

  StreamController<int> _controllerSlider = StreamController();
  Stream<int> get listenerSlider => _controllerSlider.stream;

  StreamController<int> _controllerSegment = StreamController();
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

  void changeSlider(int value, { bool updateSettings = true }) {
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