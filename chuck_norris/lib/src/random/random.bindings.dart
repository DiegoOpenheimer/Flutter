import 'package:chuck_norris/src/random/random.viewmodel.dart';
import 'package:chuck_norris/src/random/repository/random.repositoryImpl.dart';
import 'package:get/get.dart';

class RandomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RandomViewModel(RandomRepositoryImpl(Get.find())));
  }
}