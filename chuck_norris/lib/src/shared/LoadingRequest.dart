import 'package:get/get.dart';

mixin LoadingRequest {
  RxBool loading = false.obs;
  RxString error = "".obs;

  void handleRequest({ bool loading = false, String error = "" }) {
    this.loading.value = loading;
    this.error.value = error;
  }
}