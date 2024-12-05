import 'package:flutter_test/flutter_test.dart';

/// Example: Then I see exactly {4} {SomeWidget} widgets
Future<void> iSeeExactlyWidgets(
  WidgetTester tester,
  int count,
  Type type,
) async {
  await Future.delayed(Duration(seconds: 2));
  expect(find.byType(type, skipOffstage: false), findsNWidgets(count));
}
