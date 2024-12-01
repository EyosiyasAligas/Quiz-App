import 'package:dartz/dartz.dart';
import 'package:quiz_app/features/quiz/data/models/question_model.dart';

import '../../domain/repositories/abstract_quiz_repository.dart';
import '../data_sources/remote/abstract_quiz_api.dart';
import '../models/quiz_model.dart';

class QuizRepositoryImplementation extends AbstractQuizRepository {
  final AbstractQuizApi api;

  QuizRepositoryImplementation(this.api);

  @override
  Future<Either<Exception, List<QuizModel>>> fetchQuiz() async {
    try {
      final List<QuizModel> quiz = await api.fetchQuiz();
      return Right(quiz);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, QuizModel>> addQuiz(quiz) async {
    var quizModel = QuizModel(
      id: quiz.id,
      title: quiz.title,
      questions: quiz.questions.map((question) {
        return QuestionModel(
          id: question.id,
          questionText: question.questionText,
          correctAnswer: question.correctAnswer,
          options: question.options,
          selectedAnswer: question.selectedAnswer,
        );
      }).toList(),
    );
    try {
      final QuizModel addedQuiz = await api.addQuiz(quizModel);
      return Right(addedQuiz);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
