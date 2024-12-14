import 'package:dartz/dartz.dart';
import 'package:quiz_app/features/history/domain/entities/filter_params_entity.dart';

import '../../../../core/network/errors/failures.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/history_entity.dart';
import '../repositories/abstract_history_repository.dart';

class FetchHistoryByFilterUseCase extends UseCase<List<HistoryEntity>, FilterParamsEntity> {
  final AbstractHistoryRepository repository;

  FetchHistoryByFilterUseCase(this.repository);

  @override
  Future<Either<Failure, List<HistoryEntity>>> call(FilterParamsEntity? params) async {
    final result = await repository.fetchHistoryByFilter(params!);

    return result.fold(
          (failure) => Left(failure),
          (historyList) => Right(historyList),
    );
  }
}
