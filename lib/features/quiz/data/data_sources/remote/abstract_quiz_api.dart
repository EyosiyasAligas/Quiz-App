import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../models/quiz_model.dart';

abstract class AbstractQuizApi {


  Future<List<QuizModel>> fetchQuiz();

  Future<QuizModel> addQuiz(QuizModel quiz);
}