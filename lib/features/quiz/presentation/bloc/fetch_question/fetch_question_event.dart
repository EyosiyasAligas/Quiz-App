part of 'fetch_question_bloc.dart';

sealed class FetchQuestionEvent extends Equatable {
  const FetchQuestionEvent();
}

class FetchQuestion extends FetchQuestionEvent {

  @override
  List<Object?> get props => [];
}