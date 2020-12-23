import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UI {

  void showSnackBar(String message) {
    Get.showSnackbar(GetBar(
      backgroundColor: Colors.red,
      icon: Icon(Icons.dangerous, color: Colors.white),
      shouldIconPulse: true,
      overlayBlur: 1,
      message: message,
      duration: const Duration(seconds: 5),
      forwardAnimationCurve: Curves.easeInOutQuart,
      dismissDirection: SnackDismissDirection.HORIZONTAL,
      snackPosition: SnackPosition.TOP,
    ));
  }

}