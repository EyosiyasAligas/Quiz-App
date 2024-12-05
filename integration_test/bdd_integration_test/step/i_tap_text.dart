import 'package:flutter_test/flutter_test.dart';

/// Example: When I tap {'some'} text
Future<void> iTapText(
  WidgetTester tester,
  String text,
) async {
  await Future.delayed(Duration(seconds: 1));
  await tester.tap(find.text(text));
  await tester.pumpAndSettle();
}
