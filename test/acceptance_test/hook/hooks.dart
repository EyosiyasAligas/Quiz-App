import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:quiz_app/shared/service_locator.dart';

import '../../quiz_impl_api_test.mocks.dart';


abstract class Hooks {
   Hooks._();

  static FutureOr<void> beforeEach(String title, [List<String>? tags]) {
    // Add logic for beforeEach
  }

  static late List<Map<String, dynamic>> mockFetchData;
  static late Map<String, dynamic> mockPostData;

  static Future<void> beforeAll() async {

    final mockDio = MockDio();
    sl.registerSingleton<Dio>(mockDio);
    // await initAppInjections();

    RequestOptions requestOptions = RequestOptions(path: 'test');
    mockFetchData = [
      {
        'id': '1',
        'title': 'Quiz 1',
        'questions': [
          {
            'id': '1',
            'questionText': 'What is 1 + 1?',
            'options': ['1', '2', '3', '4'],
            'correctAnswer': '2',
            'selectedAnswer': '',
          },
        ],
      },
    ];

    mockPostData = {
        'id': '',
        'title': 'Bio Quiz',
        'questions': [
          {
            'id': '',
            'questionText': 'What is the powerhouse of the cell?',
            'options': [
              'Nucleus',
              'Mitochondria',
              'Ribosome',
              'Endoplasmic Reticulum'
            ],
            'correctAnswer': 'Mitochondria',
            'selectedAnswer': '',
          },
        ],
    };

    when(
      mockDio.post(
        'https://6737356faafa2ef222330993.mockapi.io/api/quiz',
        data: anyNamed('data'),
        options: anyNamed('options'),
      ),
    ).thenAnswer((_) async {
      mockFetchData.add(mockPostData);
      // await Future.delayed(const Duration(seconds: 1));
      return Response(
        data: mockPostData,
        // statusCode: 200,
        requestOptions: requestOptions,
      );
    });

    when(
      mockDio.get(
        'https://6737356faafa2ef222330993.mockapi.io/api/quiz',
        data: anyNamed('data'),
        options: anyNamed('options'),
      ),
    ).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 1));
      return Response(
        data: mockFetchData,
        statusCode: 200,
        requestOptions: requestOptions,
      );
    });
  }
  
  static FutureOr<void> afterEach(
    String title,
    bool success, [
    List<String>? tags,
  ]) {
    // Add logic for afterEach
    var mockDio = sl<Dio>();
    final mockDioException = DioException(
      requestOptions: RequestOptions(
        path: 'https://6737356faafa2ef222330993.mockapi.io/api/quiz',
      ),
      type: DioExceptionType.badResponse,
      response: Response(
        requestOptions: RequestOptions(
          path: 'https://6737356faafa2ef222330993.mockapi.io/api/quiz',
        ),
        statusCode: 500,
      ),
    );

    when(
      mockDio.get(
        'https://6737356faafa2ef222330993.mockapi.io/api/quiz',
        options: anyNamed('options'),
      ),
    ).thenThrow(mockDioException);

    when(
      mockDio.post(
        'https://6737356faafa2ef222330993.mockapi.io/api/quiz',
        data: anyNamed('data'),
        options: anyNamed('options'),
      ),
    ).thenThrow(mockDioException);
  }
  
  static FutureOr<void> afterAll() {
    // Add logic for afterAll
  }
}
