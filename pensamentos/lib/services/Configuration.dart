

import 'package:shared_preferences/shared_preferences.dart';

abstract class ValueConfiguration {

  static const String automatic = 'automatic';
  static const String timer = 'timer';
  static const String segment = 'segment';

}


class Configuration {

  static final Configuration _instance = Configuration._();
  SharedPreferences _preferences;

  Configuration._();

  factory Configuration() => _instance;

  void initialize() async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
  }

  Future<SharedPreferences> get preferences async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _preferences;
  }

  Future<bool> get automatic async {
    SharedPreferences prefs = await preferences;
    return prefs.getBool(ValueConfiguration.automatic);
  }

  Future<void> setAutomatic(bool value) async {
    SharedPreferences prefs = await preferences;
    prefs.setBool(ValueConfiguration.automatic, value);
  }

  Future<int> get timer async {
    SharedPreferences prefs = await preferences;
    return prefs.getInt(ValueConfiguration.timer) ?? 8;
  }

  Future<void> setTimer(int value) async {
    SharedPreferences prefs = await preferences;
    prefs.setInt(ValueConfiguration.timer, value);
  }

  Future<int> get segment async {
    SharedPreferences prefs = await preferences;
    return prefs.getInt(ValueConfiguration.segment);
  }

  Future<void> setSegment(int value) async {
    SharedPreferences prefs = await preferences;
    prefs.setInt(ValueConfiguration.segment, value);
  }

}