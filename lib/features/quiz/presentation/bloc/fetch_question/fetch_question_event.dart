part of 'fetch_question_bloc.dart';

sealed class FetchQuestionEvent extends Equatable {
  const FetchQuestionEvent();
}

class FetchQuestion extends FetchQuestionEvent {
  final QuizParams quizParams;

  const FetchQuestion({required this.quizParams});
  @override
  List<Object?> get props => [];
}