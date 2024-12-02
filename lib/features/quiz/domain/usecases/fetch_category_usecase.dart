import 'package:dartz/dartz.dart';
import 'package:quiz_app/features/quiz/domain/entities/quiz_params.dart';

import '../../../../core/network/errors/failures.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/category_entity.dart';
import '../repositories/abstract_quiz_repository.dart';

class FetchCategoryUseCase extends UseCase<List<CategoryEntity>, NoParams> {
  final AbstractQuizRepository repository;

  FetchCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(NoParams? params) async {
    final result = await repository.fetchCategories();

    return result.fold(
      (failure) => Left(failure),
      (categories) => Right(categories),
    );
  }
}

