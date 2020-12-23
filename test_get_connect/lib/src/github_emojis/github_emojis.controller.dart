import 'package:get/get.dart';
import 'package:test_get_connect/src/core/ui.service.dart';
import 'package:test_get_connect/src/github_emojis/github_emojis.model.dart';
import 'package:test_get_connect/src/github_emojis/github_emojis.repository.dart';

class GithubEmojisController extends GetxController with StateMixin<List<Emojis>> {

  final GithubEmojisRepository _repository;
  final UI _ui;

  GithubEmojisController(this._repository, this._ui);

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future loadData() async {
    try {
      change([], status: RxStatus.loading());
      var result = await _repository.getEmojis();
      change(result, status: RxStatus.success());
    } on String catch (value) {
      _ui.showSnackBar(value);
      change([], status: RxStatus.error(value));
    }
  }

}