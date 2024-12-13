import '../../models/history_model.dart';

abstract class AbstractHistoryLocalDataSource {
  Future<List<HistoryModel>> fetchAllHistory();
  Future<void> cacheHistory(HistoryModel history);
}