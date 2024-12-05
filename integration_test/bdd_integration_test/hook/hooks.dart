import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:quiz_app/core/utils/network_constants.dart';
import 'package:quiz_app/shared/service_locator.dart';

import '../../../test/unit_test/fetch_category_test.mocks.dart';

abstract class Hooks {
  const Hooks._();
  
  static FutureOr<void> beforeEach(String title, [List<String>? tags]) {
    // Add logic for beforeEach
  }
  
  static Future<void> beforeAll() async {
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

    sl.registerSingleton<Dio>(mockDio);
    await initAppInjections();

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
  }
  
  static FutureOr<void> afterEach(
    String title,
    bool success, [
    List<String>? tags,
  ]) {
    // Add logic for afterEach
  }
  
  static FutureOr<void> afterAll() {
    // Add logic for afterAll
  }
}
