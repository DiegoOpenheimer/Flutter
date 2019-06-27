package com.toast.openheimer.flutter_plugin

import android.app.Activity
import android.util.Log
import android.widget.Toast
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

class FlutterPlugin(private val activity: Activity): MethodCallHandler {
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "flutter_plugin")
      channel.setMethodCallHandler(FlutterPlugin(registrar.activity()))
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method == "showToast") {
      val message: String? = call.argument<String>("message")
      val toastLong = call.argument<String>("long")
      var sizeToast: Int? = null
      if (toastLong == "ToastLong.LONG") {
        Log.d("LONG", toastLong)
        sizeToast = Toast.LENGTH_LONG
      } else {
        sizeToast = Toast.LENGTH_SHORT
      }
      Toast.makeText(activity, message, sizeToast).show()
      result.success("ok")
    } else {
      result.notImplemented()
    }
  }
}
