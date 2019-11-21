import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

class FlutterToast {

  static const MethodChannel platform = const MethodChannel('com.openheimer.flutter_todo/toast');

  static show({ @required String message }) async {
    assert(message != null);
    try {
      await platform.invokeMethod('show', { 'message': message });
    } catch (e) {
      debugPrint('Fail to show toast $e');
    }
  }


}