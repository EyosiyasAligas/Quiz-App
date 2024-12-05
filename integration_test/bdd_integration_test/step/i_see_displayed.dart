import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I see {'question 1'} displayed
Future<void> iSeeDisplayed(WidgetTester tester, String param1) async {
  final finder = find.byKey(Key(param1));
  expect(finder, findsOneWidget);
}
