import 'package:dartz/dartz.dart';
import 'package:quiz_app/features/history/domain/entities/filter_params_entity.dart';

import '../../../../core/network/errors/failures.dart';
import '../entities/history_entity.dart';

abstract class AbstractHistoryRepository {
  Future<Either<Failure, List<HistoryEntity>>> fetchHistory();

  Future<Either<Failure, List<HistoryEntity>>> fetchHistoryByFilter(FilterParamsEntity filterParams);

  Future<Either<Failure, void>> cacheHistory(HistoryEntity history);
}