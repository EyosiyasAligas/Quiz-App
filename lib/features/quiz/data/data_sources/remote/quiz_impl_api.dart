import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:quiz_app/core/network/errors/exceptions.dart';
import 'package:quiz_app/features/quiz/data/models/quiz_params_model.dart';

import '../../../../../core/network/errors/failures.dart';
import '../../../../../core/utils/network_constants.dart';
import '../../models/question_model.dart';
import '../../models/category_model.dart';
import 'abstract_quiz_api.dart';

class QuizImplApi extends AbstractQuizApi {
  final Dio dio;

  // constructor
  QuizImplApi(this.dio);

  @override
  Future<List<CategoryModel>> fetchCategory() async {
    try {
      final result = await dio.get(getAllCategories);
      return List<Map<String, dynamic>>.from(result.data['trivia_categories'])
          .map((e) => CategoryModel.fromJson(e))
          .toList();
    } on DioError catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw CancelTokenException(
            e.message.toString(), e.response?.statusCode);
      } else {
        throw ServerException(e.message.toString(), e.response?.statusCode);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  @override
  Future<List<QuestionModel>> fetchQuestions(QuizParamsModel params) {
    try {
      // fetch data from api
      return Future.value([]);
    } on DioError catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw CancelTokenException(
            e.message.toString(), e.response?.statusCode);
      } else {
        throw ServerException(e.message.toString(), e.response?.statusCode);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }
}
