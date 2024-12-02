import 'package:dartz/dartz.dart';

import '../../../../core/network/errors/failures.dart';
import '../entities/question_entity.dart';
import '../repositories/abstract_quiz_repository.dart';

class FetchQuizUseCase {
  final AbstractQuizRepository repository;

  FetchQuizUseCase(this.repository);

  Future<Either<Failure, List<QuestionEntity>>> call() async {
    final result = await repository.fetchQuestions();
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}