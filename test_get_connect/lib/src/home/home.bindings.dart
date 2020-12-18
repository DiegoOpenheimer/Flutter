

import 'package:get/instance_manager.dart';
import 'home.controller.dart';

class HomeBindings extends Bindings {
  
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }

}