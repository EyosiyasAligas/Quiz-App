import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:quiz_app/features/quiz/data/data_sources/remote/quiz_impl_api.dart';
import 'package:quiz_app/features/quiz/data/repositories/quiz_repository_impl.dart';
import 'package:quiz_app/main.dart' as app;
import 'package:quiz_app/shared/service_locator.dart';

@GenerateMocks([Dio])
Future<void> main() async {

  var binding =IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // late MockDio mockDio;
  //
  // setUp(() {
  //   mockDio = MockDio();
  //   sl.registerSingleton<Dio>(mockDio);
  // });

  // RequestOptions requestOptions = RequestOptions(path: 'test');

  testWidgets('Quiz Screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    // final mockResponseData = [
    //   {
    //     'id': '1',
    //     'title': 'Quiz 1',
    //     'questions': [
    //       {
    //         'id': '1',
    //         'questionText': 'What is 1 + 1?',
    //         'correctAnswer': '2',
    //         'options': ['1', '2', '3', '4'],
    //         'selectedAnswer': '',
    //       },
    //     ],
    //   },
    // ];
    //
    // when(
    //   mockDio.get(
    //     'https://6737356faafa2ef222330993.mockapi.io/api/quiz',
    //     options: anyNamed('options'),
    //   ),
    // ).thenAnswer((_) async {
    //   return Response(
    //     data: mockResponseData,
    //     statusCode: 200,
    //     requestOptions: requestOptions,
    //   );
    // });
    //
    // when(
    //   mockDio.post(
    //     'https://6737356faafa2ef222330993.mockapi.io/api/quiz',
    //     data: anyNamed('data'),
    //     options: anyNamed('options'),
    //   ),
    // ).thenAnswer((_) async {
    //   mockResponseData.add({
    //     'id': '2',
    //     'title': 'Bio Quiz',
    //     'questions': [
    //       {
    //         'id': '1',
    //         'questionText': 'What is the powerhouse of the cell?',
    //         'correctAnswer': 'Mitochondria',
    //         'options': [
    //           'Nucleus',
    //           'Mitochondria',
    //           'Ribosome',
    //           'Endoplasmic Reticulum'
    //         ],
    //         'selectedAnswer': '',
    //       },
    //     ],
    //   });
    //   return Response(
    //     data: {
    //       'id': '2',
    //       'title': 'Bio Quiz',
    //       'questions': [
    //         {
    //           'id': '1',
    //           'questionText': 'What is the powerhouse of the cell?',
    //           'correctAnswer': 'Mitochondria',
    //           'options': [
    //             'Nucleus',
    //             'Mitochondria',
    //             'Ribosome',
    //             'Endoplasmic Reticulum'
    //           ],
    //           'selectedAnswer': '',
    //         },
    //       ],
    //     },
    //     statusCode: 200,
    //     requestOptions: requestOptions,
    //   );
    // });

    app.main();
    await tester.pumpAndSettle();

    final appBarFinder = find.byKey(const Key('quiz_screen_app_bar'));
    final addFloatingActionButtonFinder =
    find.byKey(const Key('quiz_screen_floating_action_button'));
    final titleTextFieldFinder = find.byKey(const Key('title'));
    final questionTextFieldFinder = find.byKey(const Key('question'));
    final option1TextFieldFinder = find.byKey(const Key('option_0'));
    final option2TextFieldFinder = find.byKey(const Key('option_1'));
    final option3TextFieldFinder = find.byKey(const Key('option_2'));
    final option4TextFieldFinder = find.byKey(const Key('option_3'));
    final correctAnswerTextFieldFinder = find.byKey(const Key('correct_answer'));
    final addButtonFinder = find.byKey(const Key('add_button'));

    await tester.tap(addFloatingActionButtonFinder);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    await tester.enterText(titleTextFieldFinder, 'Bio Quiz');
    await Future.delayed(const Duration(seconds: 1));
    await tester.enterText(
        questionTextFieldFinder, 'What is the powerhouse of the cell?');
    await Future.delayed(const Duration(seconds: 1));
    await tester.enterText(option1TextFieldFinder, 'Nucleus');
    await Future.delayed(const Duration(seconds: 1));
    await tester.enterText(option2TextFieldFinder, 'Mitochondria');
    await Future.delayed(const Duration(seconds: 1));
    await tester.enterText(option3TextFieldFinder, 'Ribosome');
    await Future.delayed(const Duration(seconds: 1));
    await tester.enterText(option4TextFieldFinder, 'Endoplasmic Reticulum');
    await Future.delayed(const Duration(seconds: 1));
    await tester.enterText(correctAnswerTextFieldFinder, 'Mitochondria');
    await tester.pumpAndSettle();

    await tester.ensureVisible(addButtonFinder);
    await tester.tap(addButtonFinder);

    // await binding.traceAction(() async {
    //
    //   await tester.tap(addButtonFinder);
    //   await tester.pumpAndSettle();
    // },
    //   reportKey: 'add_quiz_timeline',
    // );

    // await tester.pump();

    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.text('Math Quiz'), findsOneWidget);
    expect(find.text('Science Quiz'), findsOneWidget);
    expect(find.text('test'), findsOneWidget);
    expect(find.text('Bio Quiz'), findsOneWidget);
  });
}