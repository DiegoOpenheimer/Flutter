import 'package:chuck_norris/src/categories/repository/categories.repository.dart';
import 'package:chuck_norris/src/shared/LoadingRequest.dart';
import 'package:get/get.dart';

class CategoriesViewModel extends GetxController with LoadingRequest {

  RxList<String> categories = <String>[].obs;
  final CategoriesRepository categoriesRepository;

  CategoriesViewModel(this.categoriesRepository);

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  void onClose() {
    super.onClose();
    categoriesRepository.dispose();
  }

  Future loadData() async {
    handleRequest(loading: true);
    try {
      categories.value = await categoriesRepository.getCategories();
      handleRequest(loading: false);
    } catch (e) {
      handleRequest(loading: false, error: e);
    }
  }

  
}