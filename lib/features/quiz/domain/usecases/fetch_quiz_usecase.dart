import 'package:dartz/dartz.dart';
import 'package:quiz_app/features/quiz/domain/entities/quiz_params.dart';

import '../../../../core/network/errors/failures.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/question_entity.dart';
import '../repositories/abstract_quiz_repository.dart';

class FetchQuizUseCase extends UseCase<List<QuestionEntity>, QuizParams> {
  final AbstractQuizRepository repository;

  FetchQuizUseCase(this.repository);

  @override
  Future<Either<Failure, List<QuestionEntity>>> call(QuizParams? params) async {
    final result = await repository.fetchQuestions(params!);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}