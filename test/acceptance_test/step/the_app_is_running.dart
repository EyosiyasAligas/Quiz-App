import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:quiz_app/main.dart' as app;
import 'package:quiz_app/shared/service_locator.dart';

import '../../quiz_impl_api_test.mocks.dart';

bool isIntegrationTest = false;

Future<void> theAppIsRunning(WidgetTester tester) async {
  if (isIntegrationTest) {
    await tester.pumpWidget(const app.QuizApp());
    await tester.pumpAndSettle();
  } else {
    app.main();
    await tester.pumpAndSettle();
  }
}
