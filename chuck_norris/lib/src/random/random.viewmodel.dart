
import 'package:chuck_norris/src/random/repository/random.repository.dart';
import 'package:get/get.dart';
import 'package:chuck_norris/src/random/random.model.dart';

class RandomViewModel extends GetxController {

  Rx<Random> random = Rx();
  RxBool isLoading = true.obs;
  RxString error = "".obs;
  RandomRepository _randomRepository;

  RandomViewModel(this._randomRepository);

  @override
  void onInit() {
    super.onInit();
    loadData();
  }


  @override
  void onClose() {
    super.onClose();
    _randomRepository.dispose();
  }

  Future loadData() async {
    isLoading.value = true;
    error.value = "";
    try {
      random.value = await _randomRepository.getRandom();
    } catch (e) {
      error.value = e;
    } finally {
      isLoading.value = false;
    }
  }

}