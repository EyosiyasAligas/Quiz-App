// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import './hook/hooks.dart';
import './../test/acceptance_test/step/the_app_is_running.dart';
import './../test/acceptance_test/step/i_tap_widget.dart';
import './../test/acceptance_test/step/i_enter_into_input_field.dart';
import './../test/acceptance_test/step/i_tap_text.dart';
import './../test/acceptance_test/step/i_see_added_to_the_list.dart';
import './../test/acceptance_test/step/i_see_displayed.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Hooks.beforeAll();
  });
  tearDownAll(() async {
    await Hooks.afterAll();
  });

  group('''Add Quiz''', () {
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

    testWidgets('''add quiz''', (tester) async {
      var success = true;
      try {
        await beforeEach('''add quiz''');
        await bddSetUp(tester);
        await iTapWidget(tester, 'addIcon');
        await iEnterIntoInputField(tester, 'Bio Quiz', 0);
        await iEnterIntoInputField(
            tester, 'What is the powerhouse of the cell?', 1);
        await iEnterIntoInputField(tester, 'Nucleus', 2);
        await iEnterIntoInputField(tester, 'Mitochondria', 3);
        await iEnterIntoInputField(tester, 'Ribosome', 4);
        await iEnterIntoInputField(tester, 'Endoplasmic Reticulum ', 5);
        await iEnterIntoInputField(tester, 'Endoplasmic Reticulum ', 6);
        await iTapText(tester, 'Add Quiz');
        await iSeeAddedToTheList(tester, 'Bio Quiz');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''add quiz''',
          success,
        );
      }
    });
    testWidgets('''add quiz failure''', (tester) async {
      var success = true;
      try {
        await beforeEach('''add quiz failure''');
        await bddSetUp(tester);
        await iSeeDisplayed(tester, 'error widget');
      } on TestFailure {
        success = false;
        rethrow;
      } finally {
        await afterEach(
          '''add quiz failure''',
          success,
        );
      }
    });
  });
}
