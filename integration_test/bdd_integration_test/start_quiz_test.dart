// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import './hook/hooks.dart';
import './step/the_app_is_running.dart';
import './step/i_see_exactly_widgets.dart';
import './step/i_tap_text.dart';
import './step/i_see_text.dart';
import './step/i_see_displayed.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Start Quiz''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await theAppIsRunning(tester);
    }

    Future<void> beforeEach(String title, [List<String>? tags]) async {
      await Hooks.beforeEach(title, tags);
    }

    Future<void> afterEach(String title, bool success,
        [List<String>? tags]) async {
      await Hooks.afterEach(title, success, tags);
    }

    testWidgets('''Fetch Category Success''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Fetch Category Success''');
        await bddSetUp(tester);
        await iSeeExactlyWidgets(tester, 3, DropdownMenu<Object>);
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Fetch Category Success''',
          success,
        );
      }
    });
    testWidgets('''Start quiz with random preferences''', (tester) async {
      var success = true;
      try {
        await beforeEach('''Start quiz with random preferences''');
        await bddSetUp(tester);
        await iTapText(tester, 'Start Quiz');
        await iSeeText(tester, 'Random');
        await iSeeDisplayed(tester, 'question 1');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''Start quiz with random preferences''',
          success,
        );
      }
    });
  });
}
