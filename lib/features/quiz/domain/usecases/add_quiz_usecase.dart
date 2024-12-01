import 'package:dartz/dartz.dart';
import 'package:quiz_app/features/quiz/domain/entities/quiz_entity.dart';

import '../repositories/abstract_quiz_repository.dart';

class AddQuizUseCase {
  final AbstractQuizRepository repository;

  AddQuizUseCase(this.repository);

  Future<Either<Exception, QuizEntity>> call(QuizEntity quiz) async {
    final result = await repository.addQuiz(quiz);
    print('add use: $result');
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}