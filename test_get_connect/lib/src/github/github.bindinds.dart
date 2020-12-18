

import 'package:get/instance_manager.dart';
import 'package:test_get_connect/src/github/github.controller.dart';
import 'package:test_get_connect/src/github/repositories/github.repository.impl.dart';

class GitHubBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GitHubRepositoryImpl());
    Get.lazyPut(() => GitHubController(Get.find<GitHubRepositoryImpl>(), Get.find()));
  }
}