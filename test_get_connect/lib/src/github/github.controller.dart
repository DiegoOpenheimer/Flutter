import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_get_connect/src/core/services/link.service.dart';
import 'package:test_get_connect/src/github/model/repository.dart';
import 'package:test_get_connect/src/github/repositories/github.repository.dart';

class GitHubController extends GetxController with StateMixin<List<Repository>> {

  final GitHubRepository _repository;
  final Link _link;
  Rx<Owner> owner = Rx();

  GitHubController(this._repository, this._link);

  @override
  void onInit() {
    super.onInit();
    loadData('DiegoOpenheimer');
  }

  Future loadData(String name) async {
    try {
      change([], status: RxStatus.loading());
      List<Repository> repositories = await _repository.getRepositories(name);
      if (repositories.isNotEmpty) {
        owner.value = repositories[0].owner;
      }
      change(repositories, status: RxStatus.success());
    } on String catch(e) {
      showSnack(e);
      change([], status: RxStatus.error(e));
    }
  }

  void changeSearchBar(String text) {
    loadData(text);
  }

  void openLink(Repository repository) {
    _link.launchURL(url: repository.htmlUrl);
  }

  void showSnack(String message) {
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