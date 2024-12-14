import '../../models/filter_params_model.dart';
import '../../models/history_model.dart';

abstract class AbstractHistoryLocalDataSource {
  Future<void> cacheHistory(HistoryModel history);
  Future<List<HistoryModel>> fetchAllHistory();
  Future<List<HistoryModel>> fetchHistoryByFilter(FilterParamsModel filterParams);
}