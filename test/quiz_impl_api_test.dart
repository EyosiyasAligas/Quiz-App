// import 'package:dio/dio.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
//
// import 'package:quiz_app/features/quiz/data/data_sources/remote/quiz_impl_api.dart';
// import 'package:quiz_app/features/quiz/data/models/question_model.dart';
// import 'package:quiz_app/features/quiz/data/models/category_model.dart';
//
// import 'quiz_impl_api_test.mocks.dart';
//
// @GenerateMocks([Dio])
// void main() {
//   late MockDio mockDio;
//   late QuizImplApi quizImplApi;
//
//   setUp(() {
//     mockDio = MockDio();
//     quizImplApi = QuizImplApi(mockDio);
//   });
//
//   RequestOptions requestOptions = RequestOptions(path: 'test');
//
//   group('quiz api implementation test', () {
//     // success case
//     test('Fetch Quiz - Success Case', () async {
//       final mockResponseData = [
//         {
//           'id': '1',
//           'title': 'Quiz 1',
//           'questions': [
//             {
//               'id': '1',
//               'questionText': 'What is 1 + 1?',
//               'correctAnswer': '2',
//               'options': ['1', '2', '3', '4'],
//               'selectedAnswer': '',
//             },
//           ],
//         },
//       ];
//
//       when(
//         mockDio.get(
//           'https://6737356faafa2ef222330993.mockapi.io/api/quiz',
//           options: anyNamed('options'),
//         ),
//       ).thenAnswer((_) async {
//         return Response(
//           data: mockResponseData,
//           statusCode: 200,
//           requestOptions: requestOptions,
//         );
//       });
//
//       final result = await quizImplApi.fetchQuiz();
//
//       expect(result, isA<List<QuizModel>>());
//       expect(result.length, 1);
//       expect(result.first.title, 'Quiz 1');
//     });
//
//     // failed case
//     test('Fetch Quiz - Failure case', () async {
//       final mockDioException = DioException(
//         requestOptions: RequestOptions(
//           path: 'https://6737356faafa2ef222330993.mockapi.io/api/quiz',
//         ),
//         type: DioExceptionType.badResponse,
//         response: Response(
//           requestOptions: RequestOptions(
//             path: 'https://6737356faafa2ef222330993.mockapi.io/api/quiz',
//           ),
//           statusCode: 500,
//         ),
//       );
//
//       when(
//         mockDio.get(
//           'https://6737356faafa2ef222330993.mockapi.io/api/quiz',
//           options: anyNamed('options'),
//         ),
//       ).thenThrow(mockDioException);
//
//       expect(
//         () async => await quizImplApi.fetchQuiz(),
//         throwsA(predicate((e) => e is Exception)),
//       );
//     });
//
//     // addQuiz
//     // success case
//     test('Add Quiz - Success Case', () async {
//       final mockResponseData = {
//         'id': '1',
//         'title': 'Quiz 1',
//         'questions': [
//           {
//             'id': '1',
//             'questionText': 'What is 1 + 1?',
//             'correctAnswer': '2',
//             'options': ['1', '2', '3', '4'],
//           },
//         ],
//       };
//
//       when(
//         mockDio.post(
//           'https://6737356faafa2ef222330993.mockapi.io/api/quiz',
//           data: anyNamed('data'),
//           options: anyNamed('options'),
//         ),
//       ).thenAnswer((_) async {
//         return Response(
//           data: mockResponseData,
//           statusCode: 200,
//           requestOptions: requestOptions,
//         );
//       });
//
//       final quizModel = QuizModel(
//         id: '1',
//         title: 'Quiz 1',
//         questions: [
//           QuestionModel(
//             id: '1',
//             questionText: 'What is 1 + 1?',
//             correctAnswer: '2',
//             options: ['1', '2', '3', '4'],
//           ),
//         ],
//       );
//
//       final result = await quizImplApi.addQuiz(quizModel);
//
//       expect(result, isA<QuizModel>());
//       expect(result.title, 'Quiz 1');
//     });
//
//     // failed case
//     test('Add Quiz - Failure case', () async {
//       final mockDioException = DioException(
//         requestOptions: RequestOptions(
//           path: 'https://6737356faafa2ef222330993.mockapi.io/api/quiz',
//         ),
//         type: DioExceptionType.badResponse,
//         response: Response(
//           requestOptions: RequestOptions(
//             path: 'https://6737356faafa2ef222330993.mockapi.io/api/quiz',
//           ),
//           statusCode: 500,
//         ),
//       );
//
//       when(
//         mockDio.post(
//           'https://6737356faafa2ef222330993.mockapi.io/api/quiz',
//           data: anyNamed('data'),
//           options: anyNamed('options'),
//         ),
//       ).thenThrow(mockDioException);
//
//       final quizModel = QuizModel(
//         id: '1',
//         title: 'Quiz 1',
//         questions: [
//           QuestionModel(
//             id: '1',
//             questionText: 'What is 1 + 1?',
//             correctAnswer: '2',
//             options: ['1', '2', '3', '4'],
//           ),
//         ],
//       );
//
//       expect(
//           () async => await quizImplApi.addQuiz(quizModel),
//           throwsA(
//             predicate((e) =>
//                 e is Exception &&
//                 e.toString().contains('failed to add quiz')),
//           ));
//     });
//   });
// }
