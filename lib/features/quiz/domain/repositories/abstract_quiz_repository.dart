import 'package:dartz/dartz.dart';

import '../entities/quiz_entity.dart';

abstract class AbstractQuizRepository {
  // fetch all quiz
  Future<Either<Exception, List<QuizEntity>>> fetchQuiz();

  // add quiz
  Future<Either<Exception, QuizEntity>> addQuiz(QuizEntity quiz);

// update quiz

// delete quiz
}
