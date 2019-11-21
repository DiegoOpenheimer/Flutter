package com.openheimer.flutter_todo

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugins.GeneratedPluginRegistrant
import android.widget.Toast


class MainActivity: FlutterActivity() {

  private val CHANNEL: String = "com.openheimer.flutter_todo/toast"

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    MethodChannel(flutterView, CHANNEL).setMethodCallHandler(::getMethodCallHandler)

  }

  fun getMethodCallHandler(call: MethodCall, result: Result) {
    when(call.method) {
      "show" -> {
        val message = call.argument<String>("message") as String
        Toast.makeText(applicationContext, message, Toast.LENGTH_LONG).show()
        result.success("Toast presented")
      }
      else -> result.notImplemented()
    }
  }


}
