import '../../models/history_model.dart';

abstract class AbstractHistoryLocalDataSource {
  Future<List<HistoryModel>> fetchHistories();
  Future<void> cacheHistory(HistoryModel history);
}