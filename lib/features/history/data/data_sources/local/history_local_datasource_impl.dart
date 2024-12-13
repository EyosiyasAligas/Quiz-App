import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiz_app/core/network/errors/exceptions.dart';
import 'package:quiz_app/features/history/data/data_sources/helper/database_helper.dart';
import 'package:quiz_app/features/history/data/models/history_model.dart';
import 'package:sqflite/sqflite.dart';

import 'abstract_history_local_datasource.dart';

class HistoryLocalDatasourceImpl implements AbstractHistoryLocalDataSource {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  @override
  Future<void> cacheHistory(HistoryModel history) async {
    try {
      print('start cache');
      final db = await dbHelper.database;
      final result = await db.insert(
        DatabaseHelper.tableHistory,
        history.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print("Cache History: $result");
    } on CacheException catch (e, stackTrace) {
      print("Cache Exception: $e");
      print("Stack Trace: $stackTrace");
      throw CacheException(e.message);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<HistoryModel>> fetchAllHistory() async {
    try {
      final db = await dbHelper.database;
      final List<Map<String, dynamic>> historyList =
          await db.query(DatabaseHelper.tableHistory);

      if (historyList == null) {
        return [];
      }
      final List<HistoryModel> histories = historyList
          .map((e) => HistoryModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();

      return histories;
    } on CacheException catch (e) {
      throw CacheException(e.message);
    } catch (e, stackTrace) {
      print('Fetch History Error: $e');
      print('Stack Trace: $stackTrace');
      rethrow;
    }
  }
}
