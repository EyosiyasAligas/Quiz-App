import 'package:dartz/dartz.dart';

import '../../../../core/network/errors/exceptions.dart';
import '../../../../core/network/errors/failures.dart';
import '../../../../core/utils/helper.dart';
import '../../../../core/utils/network_constants.dart';
import '../../domain/entities/quiz_params.dart';
import '../../domain/repositories/abstract_quiz_repository.dart';
import '../data_sources/local/abstract_quiz_local.dart';
import '../data_sources/remote/abstract_quiz_api.dart';
import '../models/category_model.dart';
import '../models/question_model.dart';
import '../models/quiz_params_model.dart';

class QuizRepositoryImplementation extends AbstractQuizRepository{
  final AbstractQuizApi api;
  final AbstractQuizLocal local;

  QuizRepositoryImplementation(this.api, this.local);

  @override
  Future<Either<Failure, List<CategoryModel>>> fetchCategories() async {
    try {
      List<CategoryModel> result = [];
      final bool isConnected = await Helper.isConnected();
      print('isConnected: $isConnected');
      if(isConnected) {
        result = await api.fetchCategory();
        print('result: $result');
        await local.cacheCategories(result);
      } else {
        result = await local.getCachedCategories();
      }

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
