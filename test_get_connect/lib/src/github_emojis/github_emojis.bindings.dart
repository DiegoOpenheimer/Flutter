

import 'package:get/get.dart';
import 'package:test_get_connect/src/github_emojis/github_emojis.controller.dart';
import 'package:test_get_connect/src/github_emojis/github_emojis.repository.dart';

class GithubEmojisBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GithubEmojisRepository(Get.find()));
    Get.lazyPut(() => GithubEmojisController(Get.find(), Get.find()));
  }
}