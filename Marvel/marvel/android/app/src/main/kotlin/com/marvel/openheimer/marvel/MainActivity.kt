package com.marvel.openheimer.marvel

import android.os.Bundle
import android.widget.Toast

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

  private val key: String = "com.marvel.openheimer.marvel/device"

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    handlerToast()
  }

  private fun handlerToast() {
    MethodChannel(flutterView, key).setMethodCallHandler{
      call, result ->
      when(call.method) {
        "showToast" -> {
          val message = call.argument<String>("message")
          Toast.makeText(applicationContext, message, Toast.LENGTH_LONG).show()
          result.success("ok")
        }
        else -> result.notImplemented()
      }
    }
  }
}
