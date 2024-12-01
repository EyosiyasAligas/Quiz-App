// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './hook/hooks.dart';
import './step/the_app_is_running.dart';
import './step/i_see_fetched_from_the_server.dart';
import './step/i_see_displayed.dart';

void main() {
  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Fetch Quiz''', () {
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

    testWidgets('''fetch quizzes from the server''', (tester) async {
      var success = true;
      try {
        await beforeEach('''fetch quizzes from the server''');
        await bddSetUp(tester);
        await iSeeFetchedFromTheServer(tester, 'quizList');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''fetch quizzes from the server''',
          success,
        );
      }
    });
    testWidgets('''fetch quiz failure''', (tester) async {
      var success = true;
      try {
        await beforeEach('''fetch quiz failure''');
        await bddSetUp(tester);
        await iSeeDisplayed(tester, 'error widget');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''fetch quiz failure''',
          success,
        );
      }
    });
  });
}
