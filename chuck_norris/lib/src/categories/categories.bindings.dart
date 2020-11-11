

import 'package:chuck_norris/src/categories/categories.viewmodel.dart';
import 'package:chuck_norris/src/categories/repository/categories.repositoryImpl.dart';
import 'package:get/get.dart';

class CategoriesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoriesViewModel(CategoriesRepositoryImpl(Get.find())));
  }
}