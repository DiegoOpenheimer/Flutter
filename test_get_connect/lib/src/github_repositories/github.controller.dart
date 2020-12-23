import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_get_connect/src/core/services/link.service.dart';
import 'package:test_get_connect/src/core/ui.service.dart';
import 'package:test_get_connect/src/github_repositories/model/repository.dart';
import 'package:test_get_connect/src/github_repositories/repositories/github.repository.dart';

class GitHubRepositoryController extends GetxController with StateMixin<List<Repository>> {

  final GitHubRepository _repository;
  final Link _link;
  final UI _ui;
  Rx<Owner> owner = Rx();

  GitHubRepositoryController(this._repository, this._link, this._ui);

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
      _ui.showSnackBar(e);
      change([], status: RxStatus.error(e));
    }
  }

  void changeSearchBar(String text) {
    loadData(text);
  }

  void openLink(Repository repository) {
    _link.launchURL(url: repository.htmlUrl);
  }

}