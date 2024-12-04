part of 'submit_quiz_bloc.dart';

sealed class SubmitQuizState extends Equatable {
  const SubmitQuizState();
}

final class SubmitQuizInitial extends SubmitQuizState {
  @override
  List<Object> get props => [];
}

final class SubmitQuizUpdating extends SubmitQuizState {
  final int score;

  SubmitQuizUpdating(this.score);

  @override
  List<Object> get props => [];
}

final class SubmitQuizSuccess extends SubmitQuizState {
  final int score;

  SubmitQuizSuccess(this.score);

  @override
  List<Object> get props => [score];
}
