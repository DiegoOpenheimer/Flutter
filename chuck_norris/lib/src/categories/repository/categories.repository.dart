abstract class CategoriesRepository {

  Future<List<String>> getCategories();

  void dispose();

}
