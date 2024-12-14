import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiz_app/core/network/errors/exceptions.dart';
import 'package:quiz_app/features/history/data/data_sources/helper/database_helper.dart';
import 'package:quiz_app/features/history/data/models/history_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/filter_params_model.dart';
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

      histories.sort((a, b) => b.completedAt.compareTo(a.completedAt));

      return histories;
    } on CacheException catch (e) {
      throw CacheException(e.message);
    } catch (e, stackTrace) {
      print('Fetch History Error: $e');
      print('Stack Trace: $stackTrace');
      rethrow;
    }
  }

  @override
  Future<List<HistoryModel>> fetchHistoryByFilter(
      FilterParamsModel filterParams) async {
    try {
      final filter = filterParams.toJson();
      final db = await dbHelper.database;

      // Build the query dynamically
      String query = 'SELECT * FROM ${DatabaseHelper.tableHistory}';
      List<String> conditions = [];
      List<dynamic> args = [];

      // if (date != null) {
      //   conditions.add('completed_at = ?');
      //   args.add(date);
      // }
      if (filterParams.difficulty != null) {
        conditions.add('difficulty = ?');
        args.add(filter['difficulty']);
      }
      if (filterParams.type != null) {
        conditions.add('type = ?');
        args.add(filter['type']);
      }
      if (filterParams.category != null) {
        conditions.add('category = ?');
        args.add(filter['category']);
      }
      if (filterParams.minScore != null) {
        conditions.add('score >= ?');
        args.add(filter['min_score']);
      }
      if (filterParams.maxScore != null) {
        conditions.add('score <= ?');
        args.add(filter['max_score']);
      }

      if (conditions.isNotEmpty) {
        query += ' WHERE ${conditions.join(' AND ')}';
      }

      // await Future.delayed(Duration(seconds: 2));
      final List<Map<String, dynamic>> historyList =
          await db.rawQuery(query, args);

      if (historyList == null) {
        return [];
      }

      // historyList.sort((a, b) => b['completed_at'].compareTo(a['completed_at']));
      final List<HistoryModel> histories = historyList
          .map((e) => HistoryModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      histories.sort((a, b) => b.completedAt.compareTo(a.completedAt));
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
