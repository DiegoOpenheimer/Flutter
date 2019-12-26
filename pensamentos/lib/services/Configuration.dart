

import 'package:shared_preferences/shared_preferences.dart';

abstract class ValueConfiguration {

  static const String automatic = 'automatic';
  static const bool defaultAutomatic = false;

  static const String timer = 'timer';
  static const double defaultTimer = 8.0;

  static const String segment = 'segment';
  static const int defaultSegment = 0;

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

  Future reload() async {
    return (await preferences).reload();
  }

  Future<bool> get automatic async {
    SharedPreferences prefs = await preferences;
    return prefs.getBool(ValueConfiguration.automatic) ?? ValueConfiguration.defaultAutomatic;
  }

  Future<void> setAutomatic(bool value) async {
    SharedPreferences prefs = await preferences;
    prefs.setBool(ValueConfiguration.automatic, value);
  }

  Future<double> get timer async {
    SharedPreferences prefs = await preferences;
    return prefs.getDouble(ValueConfiguration.timer) ?? ValueConfiguration.defaultTimer;
  }

  Future<void> setTimer(double value) async {
    SharedPreferences prefs = await preferences;
    prefs.setDouble(ValueConfiguration.timer, value);
  }

  Future<int> get segment async {
    SharedPreferences prefs = await preferences;
    return prefs.getInt(ValueConfiguration.segment) ?? ValueConfiguration.defaultSegment;
  }

  Future<void> setSegment(int value) async {
    SharedPreferences prefs = await preferences;
    prefs.setInt(ValueConfiguration.segment, value);
  }

}