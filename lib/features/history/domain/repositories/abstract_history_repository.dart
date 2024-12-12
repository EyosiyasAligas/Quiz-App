import 'package:dartz/dartz.dart';

import '../../../../core/network/errors/failures.dart';
import '../entities/history_entity.dart';

abstract class AbstractHistoryRepository {
  Future<Either<Failure, List<HistoryEntity>>> fetchHistory();

  Future<Either<Failure, void>> cacheHistory(HistoryEntity history);
}