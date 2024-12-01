import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I tap {'addIcon'} widget
Future<void> iTapWidget(WidgetTester tester, String param1) async {
  final finder = find.byKey(Key(param1));

  await tester.tap(finder);
  await tester.pumpAndSettle();
  // await Future.delayed(const Duration(seconds: 1));
}
