import 'package:dartz/dartz.dart';

import '../../../../core/network/errors/failures.dart';
import '../entities/category_entity.dart';
import '../repositories/abstract_quiz_repository.dart';

class FetchCategoryUseCase {
  final AbstractQuizRepository repository;

  FetchCategoryUseCase(this.repository);

  Future<Either<Failure, List<CategoryEntity>>> call() async {
    final result = await repository.fetchCategories();

    return result.fold(
      (failure) => Left(failure),
      (categories) => Right(categories),
    );
  }
}

