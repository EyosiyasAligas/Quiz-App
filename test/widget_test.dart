import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quiz_app/core/route/router.dart';
import 'package:quiz_app/core/utils/local_storage_constants.dart';
import 'package:quiz_app/core/utils/network_constants.dart';
import 'package:quiz_app/features/quiz/domain/entities/category_entity.dart';
import 'package:quiz_app/features/quiz/presentation/bloc/choose_preference/choose_preference_cubit.dart';
import 'package:quiz_app/features/quiz/presentation/bloc/fetch_category/fetch_category_bloc.dart';
import 'package:quiz_app/features/quiz/presentation/bloc/fetch_question/fetch_question_bloc.dart';
import 'package:quiz_app/features/quiz/presentation/screens/preference_screen.dart';

import 'package:quiz_app/main.dart';
import 'package:quiz_app/shared/service_locator.dart';

import 'unit_test/fetch_category_test.mocks.dart';

void main() {
  final mockDio = MockDio();
  final requestOptions = RequestOptions(path: 'test');
  final mockCategoryResponse = {
    'trivia_categories': [
      {'id': 1, 'name': 'Science'},
    ]
  };
  final mockQuestionResponse = {
    'response_code': 0,
    'results': [
      {
        'category': 'Science',
        'type': 'multiple',
        'difficulty': 'easy',
        'question': 'What is the powerhouse of the cell?',
        'correct_answer': 'Mitochondria',
        'incorrect_answers': ['Nucleus', 'Ribosome', 'Endoplasmic Reticulum'],
      },
    ],
  };

  setUpAll(() async {
    sl.registerSingleton<Dio>(mockDio);
    initAppInjections();

    when(
      mockDio.get(
        getAllCategories,
        options: anyNamed('options'),
      ),
    ).thenAnswer((_) async {
      return Response(
        data: mockCategoryResponse,
        statusCode: 200,
        requestOptions: RequestOptions(path: getAllCategories),
      );
    });

    when(
      mockDio.get(
        '$authBaseUrl/api.php',
        options: anyNamed('options'),
        queryParameters: anyNamed('queryParameters'),
      ),
    ).thenAnswer((_) async {
      return Response(
        data: mockQuestionResponse,
        statusCode: 200,
        requestOptions: RequestOptions(path: '$authBaseUrl/api.php'),
      );
    });
  });


  group('Preference Screen', () {
    testWidgets('Open app - Success Case', (WidgetTester tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          // designSize: Size(400, 600),
            child: MultiBlocProvider(
              providers: [
                BlocProvider<FetchCategoryBloc>(
                  create: (context) => sl<FetchCategoryBloc>(),
                ),
                BlocProvider<ChoosePreferenceCubit>(
                  create: (context) => ChoosePreferenceCubit(),
                ),
                BlocProvider<FetchQuestionBloc>(
                  create: (context) => sl<FetchQuestionBloc>(),
                ),
              ],
              child: MaterialApp(
                onGenerateRoute: Routes.onGenerateRouted,
                initialRoute: Routes.preferenceScreen,
              )
            ),
        ),
      );

      await tester.pumpAndSettle();

      final successFinder = find.byKey(const Key('success'));

      expect(successFinder, findsOneWidget);
      expect(find.text('Any'), findsExactly(6));
    });

    testWidgets('Open app - Failure Case', (WidgetTester tester) async {

      when(
        mockDio.get(
          getAllCategories,
          options: anyNamed('options'),
        ),
      ).thenThrow(DioException(
        requestOptions: RequestOptions(path: getAllCategories),
        response: Response(
          statusMessage: 'DioError',
          requestOptions: RequestOptions(path: getAllCategories),
          statusCode: 400,
        ),
      ));

      await tester.pumpWidget(
        ScreenUtilInit(
          // designSize: Size(400, 600),
            child: MultiBlocProvider(
              providers: [
                BlocProvider<FetchCategoryBloc>(
                  create: (context) => sl<FetchCategoryBloc>(),
                ),
                BlocProvider<ChoosePreferenceCubit>(
                  create: (context) => ChoosePreferenceCubit(),
                ),
                BlocProvider<FetchQuestionBloc>(
                  create: (context) => sl<FetchQuestionBloc>(),
                ),
              ],
              child: MaterialApp(
                onGenerateRoute: Routes.onGenerateRouted,
                initialRoute: Routes.preferenceScreen,
              )
            ),
        ),
      );

      await tester.pumpAndSettle();

      final errorFinder = find.byKey(const Key('error'));

      expect(errorFinder, findsOneWidget);
    });
  });

  testWidgets('Start Quiz - Success Case', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        // designSize: Size(400, 600),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<FetchCategoryBloc>(
                create: (context) => sl<FetchCategoryBloc>(),
              ),
              BlocProvider<ChoosePreferenceCubit>(
                create: (context) => ChoosePreferenceCubit(),
              ),
              BlocProvider<FetchQuestionBloc>(
                create: (context) => sl<FetchQuestionBloc>(),
              ),
            ],
            child: MaterialApp(
              onGenerateRoute: Routes.onGenerateRouted,
              initialRoute: Routes.preferenceScreen,
            )
          ),
      ),
    );

    await tester.pumpAndSettle();
    
    final categoryDropdownFinder = find.byType(DropdownMenu<Object>).at(0);
    final difficultyDropdownFinder = find.byType(DropdownMenu<Object>).at(1);
    final typeDropdownFinder = find.byType(DropdownMenu<Object>).at(2);
    final minusIconFinder = find.byIcon(Icons.remove);
    final plusIconFinder = find.byIcon(Icons.add);
    final startQuizFinder = find.text('Start Quiz');

    await tester.tap(categoryDropdownFinder);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Science').last);
    await tester.pumpAndSettle();
    await tester.tap(difficultyDropdownFinder);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Easy').last);
    await tester.pumpAndSettle();
    await tester.tap(typeDropdownFinder);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Multiple Choice').last);
    await tester.pumpAndSettle();
    await tester.tap(plusIconFinder);
    await tester.pumpAndSettle();
    await tester.tap(startQuizFinder);
    await tester.pumpAndSettle();

    expect(find.text('Science'), findsOneWidget);
    expect(find.text('What is the powerhouse of the cell?'), findsOneWidget);
  });
}
