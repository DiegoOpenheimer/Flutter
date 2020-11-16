import 'package:chuck_norris/src/random/repository/random.repository.dart';
import 'package:chuck_norris/src/shared/LoadingRequest.dart';
import 'package:get/get.dart';
import 'package:chuck_norris/src/shared/model/message.model.dart';

class RandomViewModel extends GetxController with LoadingRequest {
  Rx<Message> random = Rx();
  RandomRepository _randomRepository;

  RandomViewModel(this._randomRepository);

  @override
  void onClose() {
    super.onClose();
    _randomRepository.dispose();
  }

  Future loadData({String query}) async {
    random.value = null;
    loading.value = true;
    error.value = "";
    try {
      random.value = await _randomRepository.getRandom(query: query);
    } catch (e) {
      error.value = e;
    } finally {
      loading.value = false;
    }
  }
}
