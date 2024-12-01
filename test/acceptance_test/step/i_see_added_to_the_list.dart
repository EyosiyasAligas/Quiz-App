import 'package:flutter_test/flutter_test.dart';

/// Usage: I see {'Bio Quiz'} added to the list
Future<void> iSeeAddedToTheList(WidgetTester tester, String param1) async {
  // await Future.delayed(const Duration(seconds: 1));
  final textFinder = find.text(param1);
  await tester.pumpAndSettle();

  expect(textFinder, findsOneWidget);
  // await Future.delayed(const Duration(seconds: 1));
}
