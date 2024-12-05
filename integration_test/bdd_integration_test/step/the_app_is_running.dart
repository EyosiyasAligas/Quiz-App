import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/main.dart' as app;

Future<void> theAppIsRunning(WidgetTester tester) async {
  await app.main();
  await tester.pumpAndSettle();
}
