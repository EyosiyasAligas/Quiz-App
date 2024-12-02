// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
//
// import 'package:quiz_app/features/quiz/data/data_sources/remote/abstract_quiz_api.dart';
// import 'package:quiz_app/features/quiz/data/data_sources/remote/quiz_impl_api.dart';
// import 'package:quiz_app/features/quiz/data/models/question_model.dart';
// import 'package:quiz_app/features/quiz/data/models/category_model.dart';
// import 'package:quiz_app/features/quiz/data/repositories/quiz_repository_impl.dart';
// import 'package:quiz_app/features/quiz/domain/entities/question_entity.dart';
// import 'package:quiz_app/features/quiz/domain/entities/category_entity.dart';
// import 'package:quiz_app/features/quiz/domain/usecases/add_quiz_usecase.dart';
// import 'package:quiz_app/features/quiz/domain/usecases/fetch_quiz_usecase.dart';
// import 'package:quiz_app/features/quiz/presentation/bloc/add_quiz/add_quiz_bloc.dart';
// import 'package:quiz_app/features/quiz/presentation/bloc/fetch_quiz/fetch_question_bloc.dart';
// import 'package:quiz_app/features/quiz/presentation/screens/quiz_screen.dart';
// import 'package:quiz_app/main.dart';
//
// import 'widget_test.mocks.dart';
//
// class MockFetchQuizBloc extends MockBloc<FetchQuizEvent, FetchQuizState>
//     implements FetchQuizBloc {}
//
// class MockAddQuizBloc extends MockBloc<AddQuizEvent, AddQuizState>
//     implements AddQuizBloc {}
//
// // class MockQuizImplementationApi extends Mock implements AbstractQuizApi {}
// @GenerateMocks([QuizImplApi])
// void main() {
//   late MockFetchQuizBloc mockFetchQuizBloc;
//   late MockAddQuizBloc mockAddQuizBloc;
//
//   setUp(() {
//     mockFetchQuizBloc = MockFetchQuizBloc();
//     mockAddQuizBloc = MockAddQuizBloc();
//   });
//
//   testWidgets('Quiz Screen', (WidgetTester tester) async {
//     // Mock data
//     final QuizEntity quiz = QuizEntity(
//       id: '1',
//       title: 'Quiz 1',
//       questions: [
//         QuestionEntity(
//           id: '1',
//           questionText: 'What is 1 + 1?',
//           correctAnswer: '2',
//           options: ['1', '2', '3', '4'],
//           selectedAnswer: '',
//         ),
//       ],
//     );
//
//     // bio quiz
//     final QuizEntity quiz2 = QuizEntity(
//       id: '',
//       title: 'Bio Quiz',
//       questions: [
//         QuestionEntity(
//           id: '1',
//           questionText: 'What is the powerhouse of the cell?',
//           correctAnswer: 'Mitochondria',
//           options: [
//             'Nucleus',
//             'Mitochondria',
//             'Ribosome',
//             'Endoplasmic Reticulum'
//           ],
//           selectedAnswer: '',
//         ),
//       ],
//     );
//
//     // Simulate bloc states
//     whenListen(
//       mockFetchQuizBloc,
//       Stream.fromIterable([
//         FetchQuizInitial(),
//         FetchQuizLoadSuccess([quiz]), // Initial list contains only one quiz
//         // FetchQuizLoadSuccess([quiz, quiz2]), // Updated list with new quiz
//       ]),
//       initialState: FetchQuizInitial(),
//     );
//
//     whenListen(
//       mockAddQuizBloc,
//       Stream.fromIterable([
//         AddQuizInitial(),
//         AddQuizSuccess('Quiz Added SuccessFully', quiz2),
//       ]),
//       initialState: AddQuizInitial(),
//     );
//
//     await tester.pumpWidget(
//       MaterialApp(
//         home: MultiBlocProvider(
//           providers: [
//             BlocProvider<FetchQuizBloc>(
//               create: (context) => mockFetchQuizBloc..add(FetchQuiz()),
//             ),
//             BlocProvider<AddQuizBloc>(
//               create: (context) => mockAddQuizBloc,
//             ),
//           ],
//           child: const QuizScreen(),
//         ),
//       ),
//     );
//
//     await tester.pumpAndSettle();
//
//     final addFloatingActionButtonFinder =
//     find.byKey(Key('addIcon'));
//     await tester.tap(addFloatingActionButtonFinder);
//     await tester.pumpAndSettle();
//
//     // Fill the quiz form
//     await tester.enterText(find.byKey(Key('title')), 'Bio Quiz');
//     await tester.enterText(
//         find.byKey(Key('question')), 'What is the powerhouse of the cell?');
//     await tester.enterText(find.byKey(Key('option_0')), 'Nucleus');
//     await tester.enterText(find.byKey(Key('option_1')), 'Mitochondria');
//     await tester.enterText(find.byKey(Key('option_2')), 'Ribosome');
//     await tester.enterText(
//         find.byKey(Key('option_3')), 'Endoplasmic Reticulum');
//     await tester.enterText(find.byKey(Key('correct_answer')), 'Mitochondria');
//
//     // Simulate adding the quiz
//     final addButtonFinder = find.byKey(Key('add_button'));
//     await tester.ensureVisible(addButtonFinder);
//     await tester.tap(addButtonFinder);
//     await tester.pumpAndSettle();
//
//
//     await tester.pumpAndSettle();
//
//     // Verify quiz addition triggers fetch and updates the UI
//     expect(find.text('Quiz 1'), findsOneWidget);
//     expect(find.text('Bio Quiz'), findsOneWidget);
//   });
// }
