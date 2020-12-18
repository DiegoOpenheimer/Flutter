

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

class HomeController extends GetxController {

  RxInt counter = 0.obs;

  void increment() {
    counter += 1;
  }

}