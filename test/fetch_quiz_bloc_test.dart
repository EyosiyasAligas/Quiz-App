import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quiz_app/features/quiz/domain/entities/question_entity.dart';
import 'package:quiz_app/features/quiz/domain/entities/quiz_entity.dart';

import 'package:quiz_app/features/quiz/domain/usecases/fetch_quiz_usecase.dart';
import 'package:quiz_app/features/quiz/presentation/bloc/fetch_quiz/fetch_quiz_bloc.dart';

import 'fetch_quiz_bloc_test.mocks.dart';

// class MockFetchQuizUseCase extends Mock implements FetchQuizUseCase {}

@GenerateMocks([FetchQuizUseCase])
void main() {

  group('Quiz Bloc Test', () {
    MockFetchQuizUseCase mockFetchQuizUseCase = MockFetchQuizUseCase();
    QuizEntity quiz = QuizEntity(
      id: '1',
      title: 'Quiz 1',
      questions: [
        QuestionEntity(
          id: '1',
          questionText: 'What is 1 + 1?',
          correctAnswer: '2',
          options: ['1', '2', '3', '4'],
          selectedAnswer: '',
        ),
      ],
    );

    when(mockFetchQuizUseCase.call()).thenAnswer((_) async => Right([quiz]));

    blocTest(
      'Fetch Quiz Successful',
      build: () => FetchQuizBloc(mockFetchQuizUseCase),
      act: (bloc) => bloc.add(FetchQuiz()),
      expect: () => <FetchQuizState>[FetchQuizLoadSuccess([quiz])],
      skip: 1,
    );
  });
}
