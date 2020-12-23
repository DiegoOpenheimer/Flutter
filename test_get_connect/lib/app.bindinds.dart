import 'package:get/instance_manager.dart';
import 'package:test_get_connect/src/core/services/http.service.dart';
import 'package:test_get_connect/src/core/services/link.service.dart';
import 'package:test_get_connect/src/core/ui.service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(UI());
    Get.lazyPut(() => Http(), fenix: true);
    Get.lazyPut(() => Link(), fenix: true);
  }
}