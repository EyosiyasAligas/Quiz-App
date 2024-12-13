import 'package:dartz/dartz.dart';

import '../../../../core/network/errors/exceptions.dart';
import '../../../../core/network/errors/failures.dart';
import '../../domain/entities/history_entity.dart';
import '../../domain/repositories/abstract_history_repository.dart';
import '../data_sources/local/abstract_history_local_datasource.dart';
import '../models/history_model.dart';

class HistoryRepositoryImplementation implements AbstractHistoryRepository {
  final AbstractHistoryLocalDataSource api;

  HistoryRepositoryImplementation(this.api);

  @override
  Future<Either<Failure, void>> cacheHistory(HistoryEntity history) async {
    try {
      final result = await api.cacheHistory(HistoryModel.fromEntity(history));
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HistoryEntity>>> fetchHistory() async {
    try {
      final result = await api.fetchAllHistory();
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

}