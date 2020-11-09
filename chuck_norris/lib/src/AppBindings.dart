import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ChuckNorrisBindings extends Bindings {
  @override
  void dependencies() {

    BaseOptions baseOptions = BaseOptions(
      baseUrl: 'https://api.chucknorris.io/jokes',
      connectTimeout: 5000,
      sendTimeout: 5000,
      receiveTimeout: 5000
    );
    Get.put(Dio(baseOptions));
  }
}
