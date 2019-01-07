import 'package:fluttertoast/fluttertoast.dart';


class HelperToast {

  void show(String message, { bool toastLong = false }) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: toastLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT
    );

  }

}