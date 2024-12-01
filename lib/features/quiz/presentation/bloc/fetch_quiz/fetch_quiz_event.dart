part of 'fetch_quiz_bloc.dart';

sealed class FetchQuizEvent extends Equatable {
  const FetchQuizEvent();
}

class FetchQuiz extends FetchQuizEvent {

  @override
  List<Object?> get props => [];
}