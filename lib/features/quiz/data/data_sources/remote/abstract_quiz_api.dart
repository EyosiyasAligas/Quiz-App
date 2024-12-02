import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:quiz_app/features/quiz/data/models/question_model.dart';
import 'package:quiz_app/features/quiz/data/models/quiz_params_model.dart';
import 'package:quiz_app/features/quiz/domain/entities/quiz_params.dart';

import '../../models/category_model.dart';

abstract class AbstractQuizApi {


  Future<List<CategoryModel>> fetchCategory();

  Future<List<QuestionModel>> fetchQuestions(QuizParamsModel params);
}