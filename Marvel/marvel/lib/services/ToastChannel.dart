
import 'package:flutter/services.dart';

class ToastChannel {

  static String key = 'com.marvel.openheimer.marvel/device';
  static var platform = MethodChannel(key);

  static showToast(String message) async {
    try {
      await platform.invokeMethod('showToast', { 'message': message });
    } on MissingPluginException catch(e) {
      print(e.message);
    }
  }

}