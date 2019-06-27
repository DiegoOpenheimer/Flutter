import 'dart:async';

import 'package:flutter/services.dart';

enum ToastLong { SHORT, LONG }

class FlutterPlugin {
  static const MethodChannel _channel =
      const MethodChannel('flutter_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<Null> showToas(String message, ToastLong long) async {
    try {
      Map<String, dynamic> map = new Map();
      map.putIfAbsent("message", () => message);
      map.putIfAbsent("long", () => long.toString());
      await _channel.invokeMethod("showToast", map);
    } catch(e) {
      print(e.toString());
    }
  }
}
