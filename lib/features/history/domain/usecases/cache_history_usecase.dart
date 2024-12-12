import 'package:dartz/dartz.dart';

import '../../../../core/network/errors/failures.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/history_entity.dart';
import '../repositories/abstract_history_repository.dart';

class CacheHistoryUseCase extends UseCase<void, HistoryEntity> {
  final AbstractHistoryRepository repository;

  CacheHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(HistoryEntity? params) async {
    final result = await repository.cacheHistory(params!);

    return result.fold(
          (failure) => Left(failure),
          (_) => const Right(null),
    );
  }
}
