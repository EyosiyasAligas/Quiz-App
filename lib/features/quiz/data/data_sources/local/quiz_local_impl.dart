import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiz_app/features/quiz/data/models/category_model.dart';

import '../../../../../core/utils/local_storage_constants.dart';
import '../../../domain/entities/category_entity.dart';
import 'abstract_quiz_local.dart';

class QuizLocalImplementation implements AbstractQuizLocal {
  @override
  Future<void> cacheCategories(List<CategoryModel> categories) async {
    try {
      final formattedData = categories.map((category) => category.toJson()).toList();
      final box = Hive.box(categoryBoxKey);
      box.put(categoriesKey, formattedData);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<CategoryModel>> getCachedCategories() async {
    try {
      final box = Hive.box(categoryBoxKey);
      final result = box.get(categoriesKey);
      if (result == null) {
        return [];
      }
      final List<CategoryModel> categories =
          (result as List<dynamic>)
              .map((e) => CategoryModel.fromJson(Map<String, dynamic>.from(e)))
              .toList();

      return categories;
    } catch (e) {
      return [];
    }
  }
}
