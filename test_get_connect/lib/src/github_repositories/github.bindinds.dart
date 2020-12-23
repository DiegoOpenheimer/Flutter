import 'package:get/instance_manager.dart';
import 'package:test_get_connect/src/github_repositories/github.controller.dart';
import 'package:test_get_connect/src/github_repositories/repositories/github.repository.impl.dart';

class GitHubRepositoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GitHubRepositoryImpl(Get.find()));
    Get.lazyPut(() => GitHubRepositoryController(Get.find<GitHubRepositoryImpl>(), Get.find(), Get.find()));
  }
}