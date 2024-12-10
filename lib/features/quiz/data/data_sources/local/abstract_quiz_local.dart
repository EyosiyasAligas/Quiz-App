import '../../models/category_model.dart';

abstract class AbstractQuizLocal {
  Future<void> cacheCategories(List<CategoryModel> categories);
  Future<List<CategoryModel>> getCachedCategories();
}