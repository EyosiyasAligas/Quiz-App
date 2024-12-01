import 'package:dartz/dartz.dart';
import 'package:quiz_app/features/quiz/domain/entities/quiz_entity.dart';

import '../repositories/abstract_quiz_repository.dart';

class FetchQuizUseCase {
  final AbstractQuizRepository repository;

  FetchQuizUseCase(this.repository);

  Future<Either<Exception, List<QuizEntity>>> call() async {
    final result = await repository.fetchQuiz();
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}