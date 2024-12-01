import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I see {'quizList'} fetched from the server
Future<void> iSeeFetchedFromTheServer(
    WidgetTester tester, String param1) async {
  final finder = find.byKey(Key(param1));
  expect(finder, findsOneWidget);
  // await Future.delayed(const Duration(seconds: 1));
}
