import 'package:dio/dio.dart';
import 'package:quiz_app/core/network/errors/exceptions.dart';

import '../../../../../core/network/errors/failures.dart';
import '../../models/question_model.dart';
import '../../models/category_model.dart';
import 'abstract_quiz_api.dart';

class QuizImplApi extends AbstractQuizApi {

  final Dio dio;

  // constructor
  QuizImplApi(this.dio);

  @override
  Future<List<CategoryModel>> fetchCategory() {
    try {
      // fetch data from api
      return Future.value([]);
    } on DioError catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw CancelTokenException(e.message.toString(), e.response?.statusCode);
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
  Future<List<QuestionModel>> fetchQuestions() {
    try {
      // fetch data from api
      return Future.value([]);
    } on DioError catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw CancelTokenException(e.message.toString(), e.response?.statusCode);
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
