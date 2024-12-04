part of 'submit_quiz_bloc.dart';

sealed class SubmitQuizEvent extends Equatable {
  const SubmitQuizEvent();
}

final class SubmitQuiz extends SubmitQuizEvent {
  final int score;

  SubmitQuiz(this.score);

  @override
  List<Object> get props => [score];
}

final class SubmitQuizUpdated extends SubmitQuizEvent {
  final int score;

  SubmitQuizUpdated(this.score);

  @override
  List<Object> get props => [];
}
