import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../models/question_model.dart';
import '../../models/quiz_model.dart';
import 'abstract_quiz_api.dart';

class QuizImplApi extends AbstractQuizApi {
  // dummy data and simulate real questions about the quiz
  List<QuizModel> dummyQuizData = [
    QuizModel(
      id: '1',
      title: 'Math Quiz',
      questions: [
        QuestionModel(
          id: '1',
          questionText: 'What is 2 + 2?',
          options: const ['3', '4', '5', '6'],
          correctAnswer: '4',
        ),
        QuestionModel(
          id: '2',
          questionText: 'What is 5 x 5?',
          options: const ['20', '25', '30', '35'],
          correctAnswer: '25',
        ),
        QuestionModel(
          id: '3',
          questionText: 'What is 10 - 5?',
          options: const ['3', '4', '5', '6'],
          correctAnswer: '5',
        ),
        QuestionModel(
          id: '4',
          questionText: 'What is 10 / 2?',
          options: const ['3', '4', '5', '6'],
          correctAnswer: '5',
        ),
      ],
    ),
    QuizModel(
      id: '2',
      title: 'Science Quiz',
      questions: [
        QuestionModel(
          id: '1',
          questionText: 'What is the powerhouse of the cell?',
          options: const [
            'Nucleus',
            'Mitochondria',
            'Ribosome',
            'Endoplasmic Reticulum'
          ],
          correctAnswer: 'Mitochondria',
        ),
        QuestionModel(
          id: '2',
          questionText: 'What is the largest planet in our solar system?',
          options: const ['Earth', 'Mars', 'Jupiter', 'Saturn'],
          correctAnswer: 'Jupiter',
        ),
        QuestionModel(
          id: '3',
          questionText: 'What is the chemical symbol for water?',
          options: const ['H2O', 'CO2', 'O2', 'H2SO4'],
          correctAnswer: 'H2O',
        ),
        QuestionModel(
          id: '4',
          questionText: 'What is the process of plants making food called?',
          options: const [
            'Photosynthesis',
            'Respiration',
            'Transpiration',
            'Germination'
          ],
          correctAnswer: 'Photosynthesis',
        ),
      ],
    ),
  ];

  final Dio dio;

  // constructor
  QuizImplApi(this.dio);

  final url = 'https://6737356faafa2ef222330993.mockapi.io/api/quiz';

  @override
  Future<List<QuizModel>> fetchQuiz() async {
    try {
      var response = await dio.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      List<QuizModel> quizzes = [];
      if(kDebugMode) {
        print('fetchQuiz response: ${response.data}');
      }
      response.data.forEach((quiz) {
        quizzes.insert(0, QuizModel.fromJson(quiz));
      });
      return quizzes;
    } on DioException catch (dioError) {
      if(kDebugMode) {
        print('DioException: $dioError');
      }
      throw Exception('Failed to fetch quiz data');
    } catch (e) {
      print('error: $e');
      throw Exception('Failed to fetch quiz data');
    }
  }

  @override
  Future<QuizModel> addQuiz(QuizModel quiz) async {
    try {
      var response = await dio.post(
        url,
        data: quiz.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if(kDebugMode) {
        print('addQuiz response: ${response.data}');
      }

      return QuizModel.fromJson(response.data);
    } on DioException catch (dioError) {
      if(kDebugMode) {
        print('DioException: $dioError');
      }
      throw Exception('failed to add quiz');
    } catch (e) {
      if(kDebugMode) {
        print('error: $e');
      }
      throw Exception('failed to add quiz');
    }
  }
}
