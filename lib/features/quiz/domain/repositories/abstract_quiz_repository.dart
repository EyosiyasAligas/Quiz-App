import 'package:dartz/dartz.dart';
import 'package:quiz_app/features/quiz/domain/entities/question_entity.dart';
import 'package:quiz_app/features/quiz/domain/entities/quiz_params.dart';

import '../../../../core/network/errors/failures.dart';
import '../entities/category_entity.dart';

abstract class AbstractQuizRepository {
  // fetch all categories
  Future<Either<Failure, List<CategoryEntity>>> fetchCategories();

  // fetch all questions
  Future<Either<Failure, List<QuestionEntity>>> fetchQuestions(QuizParams params);
}
