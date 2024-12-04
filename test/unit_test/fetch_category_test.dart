import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quiz_app/core/network/errors/exceptions.dart';
import 'package:quiz_app/core/utils/network_constants.dart';
import 'package:quiz_app/features/quiz/data/data_sources/remote/quiz_impl_api.dart';
import 'package:quiz_app/features/quiz/data/models/category_model.dart';

import 'fetch_category_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late QuizImplApi quizImplApi;
  final requestOptions = RequestOptions(path: 'test');
  final mockCategoryResponse = {
    'trivia_categories': [
      {'id': 1, 'name': 'General Knowledge'},
      {'id': 2, 'name': 'Entertainment: Books'},
    ]
  };

  final mockException = DioException(
    requestOptions: RequestOptions(
      path: getAllCategories,
    ),
    type: DioExceptionType.badResponse,
    response: Response(
      requestOptions: RequestOptions(
        path: getAllCategories,
      ),
      statusCode: 2,
    ),
  );

  setUp(() {
    mockDio = MockDio();
    quizImplApi = QuizImplApi(mockDio);

    when(
      mockDio.get(
        getAllCategories,
        options: anyNamed('options'),
      ),
    ).thenAnswer((_) async {
      return Response(
        data: mockCategoryResponse,
        statusCode: 200,
        requestOptions: requestOptions,
      );
    });
  });

  group('Fetch Categories', () {
    test('Fetch Categories - Success Case', () async {
      final result = await quizImplApi.fetchCategory();
      expect(result, isA<List<CategoryModel>>());
      expect(result.length, 2);
      expect(result.first.name, 'General Knowledge');
    });

    test('Fetch Categories - Server Exception', () async {
      when(
        mockDio.get(
          getAllCategories,
          options: anyNamed('options'),
        ),
      ).thenThrow(mockException);

      var result;

      try {
        result = await quizImplApi.fetchCategory();
      } catch (e) {
        result = e;
      }

      expect(result, isA<ServerException>());
    });
  });
}
