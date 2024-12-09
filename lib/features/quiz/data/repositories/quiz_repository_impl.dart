import 'package:dartz/dartz.dart';
import 'package:quiz_app/core/network/errors/failures.dart';
import 'package:quiz_app/features/quiz/data/models/question_model.dart';
import 'package:quiz_app/features/quiz/data/models/quiz_params_model.dart';
import 'package:quiz_app/features/quiz/domain/entities/quiz_params.dart';

import '../../../../core/network/errors/exceptions.dart';
import '../../domain/repositories/abstract_quiz_repository.dart';
import '../data_sources/remote/abstract_quiz_api.dart';
import '../models/category_model.dart';

class QuizRepositoryImplementation extends AbstractQuizRepository {
  final AbstractQuizApi api;

  QuizRepositoryImplementation(this.api);

  @override
  Future<Either<Failure, List<CategoryModel>>> fetchCategories() async {
    try {
      final result = await api.fetchCategory();

      return Right(result..insert(0,  CategoryModel(id: -1, name: 'Any')));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(ServerFailure(e.toString(), null));
    }
  }

  @override
  Future<Either<Failure, List<QuestionModel>>> fetchQuestions(
      QuizParams params) async {
    final QuizParamsModel paramsModel = QuizParamsModel(
      amount: params.amount,
      categoryId: params.categoryId,
      difficulty: params.difficulty,
      type: params.type,
    );

    try {
      final result = await api.fetchQuestions(paramsModel);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } catch (e) {
      return Left(ServerFailure(e.toString(), null));
    }
  }
}
