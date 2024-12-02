import 'package:dartz/dartz.dart';
import 'package:quiz_app/core/network/errors/failures.dart';
import 'package:quiz_app/features/quiz/data/models/question_model.dart';
import 'package:quiz_app/features/quiz/domain/entities/category_entity.dart';
import 'package:quiz_app/features/quiz/domain/entities/question_entity.dart';

import '../../domain/repositories/abstract_quiz_repository.dart';
import '../data_sources/remote/abstract_quiz_api.dart';
import '../models/category_model.dart';

class QuizRepositoryImplementation extends AbstractQuizRepository {
  final AbstractQuizApi api;

  QuizRepositoryImplementation(this.api);

  @override
  Future<Either<Failure, List<CategoryEntity>>> fetchCategories() {
    // TODO: implement fetchCategories
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<QuestionEntity>>> fetchQuestions() {
    // TODO: implement fetchQuestions
    throw UnimplementedError();
  }
}
