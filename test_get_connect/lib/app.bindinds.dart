

import 'package:get/instance_manager.dart';
import 'package:test_get_connect/src/core/services/link.service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Link(), fenix: true);
  }
}