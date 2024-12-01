import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I see {'error_widget'} displayed
Future<void> iSeeDisplayed(WidgetTester tester, String param1) async {
  final finder = find.byKey(Key(param1));

  expect(finder, findsOneWidget);
}
