import 'package:chuck_norris/src/random/random.viewmodel.dart';
import 'package:chuck_norris/src/random/random.widget.dart';
import 'package:chuck_norris/src/random/repository/random.repositoryImpl.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

List<GetPage> routes = [
  GetPage(
      name: '/random', page: () => RandomWidget(), binding: RandomBinding()),
];

class RandomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RandomViewModel(RandomRepositoryImpl(Get.find())));
  }
}
