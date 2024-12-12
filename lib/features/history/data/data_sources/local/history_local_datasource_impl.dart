import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiz_app/core/network/errors/exceptions.dart';
import 'package:quiz_app/features/history/data/models/history_model.dart';

import '../../../../../core/utils/local_storage_constants.dart';
import 'abstract_history_local_datasource.dart';

class HistoryLocalDatasourceImpl implements AbstractHistoryLocalDataSource {

  @override
  Future<void> cacheHistory(HistoryModel history) async {
    try {
      final box = Hive.box(historyBoxKey);
      final List<dynamic> historyList = await box.get(historyKey) ?? [];
      historyList.add(history.toJson());
      await box.put(historyKey, historyList);
    } on CacheException catch (e) {
      throw CacheException(e.message);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<HistoryModel>> fetchHistories() async {
    try {
      final box = Hive.box(historyBoxKey);
      final List<dynamic> historyList = await box.get(historyKey);
      print('historyList from fetch: $historyList');
      final List<HistoryModel> histories = historyList
          .map((e) => HistoryModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();

      print('histories: $histories');
      return Future.value(histories);
    } on CacheException catch (e) {
      print('CacheException: ${e.message}');
      throw CacheException(e.message);
    } catch (e, stackTrace) {
      print('Exception: $e');
      print('stackTrace: $stackTrace');
      rethrow;
    }
  }

}