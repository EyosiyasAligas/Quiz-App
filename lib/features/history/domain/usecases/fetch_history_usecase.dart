import 'package:dartz/dartz.dart';

import '../../../../core/network/errors/failures.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/history_entity.dart';
import '../repositories/abstract_history_repository.dart';

class FetchHistoryUseCase extends UseCase<List<HistoryEntity>, NoParams> {
  final AbstractHistoryRepository repository;

  FetchHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<HistoryEntity>>> call(NoParams? params) async {
    final result = await repository.fetchHistory();

    return result.fold(
          (failure) => Left(failure),
          (historyList) => Right(historyList),
    );
  }
}
